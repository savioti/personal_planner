import 'package:dartz/dartz.dart';
import 'package:personal_planner/app/modules/event/data/datasources/event_datasource.dart';
import 'package:personal_planner/app/modules/event/data/models/add_event_request.dart';
import 'package:personal_planner/app/modules/event/domain/entities/event_entity.dart';
import 'package:personal_planner/app/modules/event/domain/repositories/event_repository.dart';
import 'package:personal_planner/app/shared/error/failure.dart';

class EventRepositoryImpl implements EventRepository {
  final EventDatasource _datasource;

  EventRepositoryImpl({required EventDatasource datasource})
    : _datasource = datasource;

  @override
  Future<Either<Failure, EventEntity>> addEvent(AddEventRequest request) async {
    try {
      final eventModel = await _datasource.addEvent(request);
      return Right(eventModel.toEntity());
    } catch (e) {
      return Left(
        Failure(
          message: 'EventRepositoryImpl - Failed to add event: ${e.toString()}',
        ),
      );
    }
  }
}
