import 'package:dartz/dartz.dart';
import 'package:personal_planner/app/modules/event/data/requests/add_event_request.dart';
import 'package:personal_planner/app/modules/event/data/requests/get_events_request.dart';
import 'package:personal_planner/app/modules/event/domain/entities/event_entity.dart';
import 'package:personal_planner/app/modules/event/domain/usecases/add_event_usecase.dart';
import 'package:personal_planner/app/modules/event/domain/usecases/get_events_usecase.dart';
import 'package:personal_planner/app/shared/error/failure.dart';

class EventController {
  final AddEventUsecase addEventUsecase;
  final GetEventsUsecase getEventsUsecase;

  EventController({
    required this.addEventUsecase,
    required this.getEventsUsecase,
  });

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
}
