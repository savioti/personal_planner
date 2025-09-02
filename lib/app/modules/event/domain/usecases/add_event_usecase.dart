import 'package:dartz/dartz.dart';
import 'package:personal_planner/app/modules/event/data/models/add_event_request.dart';
import 'package:personal_planner/app/modules/event/domain/entities/event_entity.dart';
import 'package:personal_planner/app/modules/event/domain/repositories/event_repository.dart';
import 'package:personal_planner/app/shared/error/failure.dart';
import 'package:personal_planner/app/shared/usecase/async_usecase.dart';

class AddEventUsecase extends AsyncUsecase<EventEntity, AddEventRequest> {
  final EventRepository _repository;

  AddEventUsecase({required EventRepository repository})
    : _repository = repository;

  @override
  Future<Either<Failure, EventEntity>> call(AddEventRequest request) async {
    try {
      return await _repository.addEvent(request);
    } catch (e) {
      return Left(
        Failure(
          message: 'AddEventUsecase - Failed to add event: ${e.toString()}',
        ),
      );
    }
  }
}
