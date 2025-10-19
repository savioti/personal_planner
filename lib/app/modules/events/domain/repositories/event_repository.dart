import 'package:dartz/dartz.dart';
import 'package:personal_planner/app/modules/events/data/requests/add_event_request.dart';
import 'package:personal_planner/app/modules/events/data/requests/delete_event_request.dart';
import 'package:personal_planner/app/modules/events/data/requests/get_events_request.dart';
import 'package:personal_planner/app/modules/events/domain/entities/event_entity.dart';
import 'package:personal_planner/app/shared/error/failure.dart';

abstract class EventRepository {
  Future<Either<Failure, EventEntity>> addEvent(AddEventRequest request);

  Future<Either<Failure, List<EventEntity>>> getEvents(
    GetEventsRequest request,
  );

  Future<Either<Failure, bool>> deleteEvent(DeleteEventRequest request);
}
