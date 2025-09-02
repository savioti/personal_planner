import 'package:dartz/dartz.dart';
import 'package:personal_planner/app/modules/event/data/requests/add_event_request.dart';
import 'package:personal_planner/app/modules/event/data/requests/delete_event_request.dart';
import 'package:personal_planner/app/modules/event/data/requests/get_events_request.dart';
import 'package:personal_planner/app/modules/event/domain/entities/event_entity.dart';
import 'package:personal_planner/app/shared/error/failure.dart';

abstract class EventRepository {
  Future<Either<Failure, EventEntity>> addEvent(AddEventRequest request);

  Future<Either<Failure, List<EventEntity>>> getEvents(
    GetEventsRequest request,
  );

  Future<Either<Failure, bool>> deleteEvent(DeleteEventRequest request);
}
