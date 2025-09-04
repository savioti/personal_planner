import 'package:dartz/dartz.dart';
import 'package:personal_planner/app/modules/events/data/requests/add_event_request.dart';
import 'package:personal_planner/app/modules/events/data/requests/delete_event_request.dart';
import 'package:personal_planner/app/modules/events/data/requests/get_events_request.dart';
import 'package:personal_planner/app/modules/events/domain/entities/event_entity.dart';
import 'package:personal_planner/app/modules/events/domain/usecases/add_event_usecase.dart';
import 'package:personal_planner/app/modules/events/domain/usecases/delete_event_usecase.dart';
import 'package:personal_planner/app/modules/events/domain/usecases/get_events_usecase.dart';
import 'package:personal_planner/app/shared/error/failure.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_planner/app/infra/dependency_injection/service_locator.dart';
import 'package:personal_planner/app/modules/events/domain/utils/event_utils.dart';
import 'package:personal_planner/app/shared/classes/range.dart';

class EventController {
  final AddEventUsecase addEventUsecase;
  final GetEventsUsecase getEventsUsecase;
  final DeleteEventUsecase deleteEventUsecase;

  EventController({
    required this.addEventUsecase,
    required this.getEventsUsecase,
    required this.deleteEventUsecase,
  }) {
    _initializeProviders();
  }

  late final Provider<EventController> eventProvider;
  late final Provider<Range<DateTime>> currentWeekDateRangeProvider;
  late final FutureProviderFamily<List<EventEntity>, Range<DateTime>>
  weekEventsProvider;

  Future<Either<Failure, EventEntity>> addEvent({
    required String title,
    required DateTime startTime,
    DateTime? endTime,
    String? description,
  }) async {
    try {
      final request = AddEventRequest(
        title: title,
        startTime: startTime,
        endTime: endTime,
        description: description,
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

  void _initializeProviders() {
    eventProvider = Provider<EventController>((ref) {
      return serviceLocator<EventController>();
    });

    currentWeekDateRangeProvider = Provider<Range<DateTime>>((ref) {
      final today = DateTime.now();
      return EventUtils.getWeekDateRange(today);
    });

    weekEventsProvider =
        FutureProvider.family<List<EventEntity>, Range<DateTime>>((
          ref,
          weekDateRange,
        ) async {
          final controller = ref.watch(eventProvider);

          final result = await controller.getEvents(
            dateRangeStart: weekDateRange.start,
            dateRangeEnd: weekDateRange.end,
          );
          return result.fold((failure) => throw failure, (events) => events);
        });
  }
}
