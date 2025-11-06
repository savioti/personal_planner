import 'package:dartz/dartz.dart';
import 'package:personal_planner/app/modules/events/data/requests/add_event_request.dart';
import 'package:personal_planner/app/modules/events/data/requests/delete_event_request.dart';
import 'package:personal_planner/app/modules/events/data/requests/edit_event_request.dart';
import 'package:personal_planner/app/modules/events/data/requests/get_events_request.dart';
import 'package:personal_planner/app/modules/events/data/requests/get_recurring_events_request.dart';
import 'package:personal_planner/app/modules/events/domain/entities/event_entity.dart';
import 'package:personal_planner/app/modules/events/domain/usecases/add_event_usecase.dart';
import 'package:personal_planner/app/modules/events/domain/usecases/delete_event_usecase.dart';
import 'package:personal_planner/app/modules/events/domain/usecases/edit_event_usecase.dart';
import 'package:personal_planner/app/modules/events/domain/usecases/get_events_usecase.dart';
import 'package:personal_planner/app/modules/events/domain/usecases/get_recurring_events_usecase.dart';
import 'package:personal_planner/app/shared/enums/recurrence_type.dart';
import 'package:personal_planner/app/shared/enums/weekday.dart';
import 'package:personal_planner/app/shared/error/failure.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_planner/app/infra/dependency_injection/service_locator.dart';
import 'package:personal_planner/app/shared/classes/range.dart';
import 'package:personal_planner/app/shared/extensions/date_time_extension.dart';

class EventController {
  final AddEventUsecase addEventUsecase;
  final GetEventsUsecase getEventsUsecase;
  final DeleteEventUsecase deleteEventUsecase;
  final EditEventUsecase editEventUsecase;
  final GetRecurringEventsUsecase getRecurringEventsUsecase;

  EventController({
    required this.addEventUsecase,
    required this.getEventsUsecase,
    required this.deleteEventUsecase,
    required this.editEventUsecase,
    required this.getRecurringEventsUsecase,
  }) {
    _initializeProviders();
  }

  late final Provider<EventController> eventControllerProvider;
  late final Provider<Range<DateTime>> currentWeekDateRangeProvider;
  late final FutureProviderFamily<List<EventEntity>, Range<DateTime>>
  weekEventsProvider;
  late final FutureProvider<List<EventEntity>> nextWeekEventsProvider;
  late final FutureProvider<List<EventEntity>> thisMonthEventsProvider;
  late final FutureProvider<List<EventEntity>> futureEventsProvider;

  Future<Either<Failure, EventEntity>> addEvent({
    required String title,
    required DateTime startTime,
    DateTime? endTime,
    String? description,
    RecurrenceType? recurrenceType,
    Set<Weekday>? recurrenceWeekdays,
    int? recurrenceInterval,
  }) async {
    try {
      final request = AddEventRequest(
        title: title,
        startTime: startTime,
        description: description,
        recurrenceType: recurrenceType,
        recurrenceWeekdays: recurrenceWeekdays,
        recurrenceInterval: recurrenceInterval,
      );

      return await addEventUsecase(request);
    } catch (e) {
      return Left(
        Failure(
          message: 'EventController - Failed to add event: ${e.toString()}',
        ),
      );
    }
  }

  Future<Either<Failure, List<EventEntity>>> getEvents({
    required DateTime dateRangeStart,
    required DateTime dateRangeEnd,
  }) async {
    try {
      final request = GetEventsRequest(
        dateRangeStart: dateRangeStart,
        dateRangeEnd: dateRangeEnd,
      );

      return await getEventsUsecase(request);
    } catch (e) {
      return Left(
        Failure(
          message: 'EventController - Failed to get events: ${e.toString()}',
        ),
      );
    }
  }

  Future<Either<Failure, bool>> deleteEvent({required String eventId}) async {
    try {
      final request = DeleteEventRequest(eventId: eventId);
      return await deleteEventUsecase(request);
    } catch (e) {
      return Left(
        Failure(
          message: 'EventController - Failed to delete event: ${e.toString()}',
        ),
      );
    }
  }

  Future<Either<Failure, EventEntity>> editEvent({
    required String eventId,
    required String title,
    required DateTime startTime,
    DateTime? endTime,
    String? description,
    RecurrenceType? recurrenceType,
    Set<Weekday>? recurrenceWeekdays,
    int? recurrenceInterval,
  }) async {
    try {
      final request = EditEventRequest(
        eventId: eventId,
        title: title,
        startTime: startTime,
        description: description,
        recurrenceType: recurrenceType,
        recurrenceWeekdays: recurrenceWeekdays,
        recurrenceInterval: recurrenceInterval,
      );

      return await editEventUsecase(request);
    } catch (e) {
      return Left(
        Failure(
          message: 'EventController - Failed to edit event: ${e.toString()}',
        ),
      );
    }
  }

  Future<Either<Failure, List<EventEntity>>> getRecurringEvents() async {
    try {
      final request = GetRecurringEventsRequest();
      final result = await getRecurringEventsUsecase(request);

      if (result.isLeft()) {
        return Left(
          result.swap().getOrElse(() => Failure(message: 'Unknown error')),
        );
      }

      final recurringEvents = result.getOrElse(() => []);
      final recurringEventInstances = <EventEntity>[];

      for (var event in recurringEvents) {
        final instances = _createRecurringEventInstances(event);
        recurringEventInstances.addAll(instances);
      }

      return Right(recurringEventInstances);
    } catch (e) {
      return Left(
        Failure(
          message:
              'EventController - Failed to get recurring events: ${e.toString()}',
        ),
      );
    }
  }

  List<EventEntity> _createRecurringEventInstances(EventEntity recurringEvent) {
    if (recurringEvent.recurrenceType == null ||
        recurringEvent.recurrenceType == RecurrenceType.none) {
      return [];
    }

    if (recurringEvent.recurrenceType == RecurrenceType.daily) {
      return _createDailyRecurringEventInstances(recurringEvent);
    }

    if (recurringEvent.recurrenceType == RecurrenceType.weekly) {
      return _createWeeklyRecurringEventInstances(recurringEvent);
    }

    if (recurringEvent.recurrenceType == RecurrenceType.monthly) {
      return _createMonthlyRecurringEventInstance(recurringEvent);
    }

    if (recurringEvent.recurrenceType == RecurrenceType.yearly) {
      return _createYearlyRecurringEventInstance(recurringEvent);
    }

    if (recurringEvent.recurrenceType ==
        RecurrenceType.firstWeekdayOfTheMonth) {
      return _createfirstMonthWeekdayRecurringEventInstance(recurringEvent);
    }

    return [];
  }

  List<EventEntity> _createDailyRecurringEventInstances(
    EventEntity recurringEvent,
  ) {
    final now = DateTime.now();
    final startOfWeek = now.getStartOfWeek();
    final daysInAWeek = 7;
    final instances = <EventEntity>[];

    for (int i = 0; i < daysInAWeek; i++) {
      final occurrenceDate = startOfWeek.add(Duration(days: i));

      final instance = EventEntity.fromRecurringEvent(
        recurringEvent: recurringEvent,
        instanceDate: occurrenceDate,
      );

      instances.add(instance);
    }

    return instances;
  }

  List<EventEntity> _createWeeklyRecurringEventInstances(
    EventEntity recurringEvent,
  ) {
    final now = DateTime.now();
    final startOfWeek = now.getStartOfWeek();
    final weekdayDateMap = _getWeekdayDateMap(startOfWeek);
    final instances = <EventEntity>[];

    for (var weekday in recurringEvent.recurrenceWeekdays ?? {}) {
      final occurrenceDate = weekdayDateMap[weekday];

      if (occurrenceDate != null) {
        final instance = EventEntity.fromRecurringEvent(
          recurringEvent: recurringEvent,
          instanceDate: occurrenceDate,
        );

        instances.add(instance);
      }
    }

    return instances;
  }

  List<EventEntity> _createMonthlyRecurringEventInstance(
    EventEntity recurringEvent,
  ) {
    final now = DateTime.now();
    final startOfWeek = now.getStartOfWeek();
    final weekMonthDays = _getWeekDates(
      startOfWeek,
    ).map((date) => date.day).toSet();

    if (!weekMonthDays.contains(recurringEvent.startTime.day)) {
      return [];
    }

    final occurrenceDate = DateTime(
      now.year,
      now.month,
      recurringEvent.startTime.day,
      recurringEvent.startTime.hour,
      recurringEvent.startTime.minute,
    );

    final instance = EventEntity.fromRecurringEvent(
      recurringEvent: recurringEvent,
      instanceDate: occurrenceDate,
    );

    return [instance];
  }

  List<EventEntity> _createYearlyRecurringEventInstance(
    EventEntity recurringEvent,
  ) {
    final now = DateTime.now();
    final startOfWeek = now.getStartOfWeek();

    final monthsInTheWeek = _getWeekDates(
      startOfWeek,
    ).map((date) => date.month).toSet();

    if (!monthsInTheWeek.contains(recurringEvent.startTime.month)) {
      return [];
    }

    final weekMonthDays = _getWeekDates(
      startOfWeek,
    ).map((date) => date.day).toSet();

    if (!weekMonthDays.contains(recurringEvent.startTime.day)) {
      return [];
    }

    final occurrenceDate = DateTime(
      now.year,
      recurringEvent.startTime.month,
      recurringEvent.startTime.day,
      recurringEvent.startTime.hour,
      recurringEvent.startTime.minute,
    );

    final instance = EventEntity.fromRecurringEvent(
      recurringEvent: recurringEvent,
      instanceDate: occurrenceDate,
    );

    return [instance];
  }

  List<EventEntity> _createfirstMonthWeekdayRecurringEventInstance(
    EventEntity recurringEvent,
  ) {
    if (recurringEvent.recurrenceWeekdays == null ||
        recurringEvent.recurrenceWeekdays?.length != 1) {
      return [];
    }

    final now = DateTime.now();
    final startOfWeek = now.getStartOfWeek();
    final lastDayOfTheWeek = startOfWeek.add(const Duration(days: 6));

    if (lastDayOfTheWeek.day > 7) {
      return [];
    }

    final weekday = recurringEvent.recurrenceWeekdays!.first;
    final weekdayIndex = weekday.toInt();

    final firstWeekdayOfMonth = lastDayOfTheWeek.getfirstWeekdayOfMonth(
      weekdayIndex,
    );

    final instance = EventEntity.fromRecurringEvent(
      recurringEvent: recurringEvent,
      instanceDate: firstWeekdayOfMonth,
    );

    return [instance];
  }

  Map<Weekday, DateTime> _getWeekdayDateMap(DateTime startOfWeek) {
    final weekdayDateMap = <Weekday, DateTime>{};
    final daysInAWeek = 7;

    for (int i = 0; i < daysInAWeek; i++) {
      final currentDate = startOfWeek.add(Duration(days: i));
      final weekdayIndex = i + 1;
      final weekday = Weekday.fromInt(weekdayIndex);
      weekdayDateMap[weekday] = currentDate;
    }

    return weekdayDateMap;
  }

  List<DateTime> _getWeekDates(DateTime startOfWeek) {
    final weekDates = <DateTime>[];
    final daysInAWeek = 7;

    for (int i = 0; i < daysInAWeek; i++) {
      final currentDate = startOfWeek.add(Duration(days: i));
      weekDates.add(currentDate);
    }

    return weekDates;
  }

  void _initializeProviders() {
    final today = DateTime.now();
    final nextWeekRange = today.getNextWeekDateRange;
    final dayAfterNextWeek = nextWeekRange.end.add(const Duration(days: 1));
    final endOfMonth = dayAfterNextWeek.monthEnd;

    eventControllerProvider = Provider<EventController>((ref) {
      return serviceLocator<EventController>();
    });

    currentWeekDateRangeProvider = Provider<Range<DateTime>>((ref) {
      return today.getWeekDateRange;
    });

    weekEventsProvider =
        FutureProvider.family<List<EventEntity>, Range<DateTime>>((
          ref,
          weekDateRange,
        ) async {
          final controller = ref.watch(eventControllerProvider);
          final eventResults = await Future.wait([
            controller.getEvents(
              dateRangeStart: weekDateRange.start,
              dateRangeEnd: weekDateRange.end,
            ),
            controller.getRecurringEvents(),
          ]);

          final weekEventsResult = eventResults[0];
          final weekEvents = weekEventsResult.fold(
            (failure) => throw failure,
            (events) => events,
          );

          final recurringEventsResult = eventResults[1];
          final recurringEvents = recurringEventsResult.fold(
            (failure) => throw failure,
            (events) => events,
          );

          return [...weekEvents, ...recurringEvents];
        });

    nextWeekEventsProvider = FutureProvider<List<EventEntity>>((ref) async {
      final controller = ref.watch(eventControllerProvider);

      final result = await controller.getEvents(
        dateRangeStart: nextWeekRange.start,
        dateRangeEnd: nextWeekRange.end,
      );
      return result.fold((failure) => throw failure, (events) => events);
    });

    thisMonthEventsProvider = FutureProvider<List<EventEntity>>((ref) async {
      final controller = ref.watch(eventControllerProvider);

      final result = await controller.getEvents(
        dateRangeStart: dayAfterNextWeek,
        dateRangeEnd: endOfMonth,
      );
      return result.fold((failure) => throw failure, (events) => events);
    });

    futureEventsProvider = FutureProvider<List<EventEntity>>((ref) async {
      final controller = ref.watch(eventControllerProvider);
      final startOfFuture = endOfMonth.add(const Duration(days: 1));
      final endOfFuture = startOfFuture.getNextSemesterDateRange.end;

      final result = await controller.getEvents(
        dateRangeStart: startOfFuture,
        dateRangeEnd: endOfFuture,
      );
      return result.fold((failure) => throw failure, (events) => events);
    });
  }
}
