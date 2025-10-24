import 'package:dartz/dartz.dart';
import 'package:personal_planner/app/modules/events/data/requests/edit_event_request.dart';
import 'package:personal_planner/app/modules/events/domain/entities/event_entity.dart';
import 'package:personal_planner/app/modules/events/domain/repositories/event_repository.dart';
import 'package:personal_planner/app/shared/error/failure.dart';
import 'package:personal_planner/app/shared/usecase/async_usecase.dart';

class EditEventUsecase extends AsyncUsecase<EventEntity, EditEventRequest> {
  final EventRepository _repository;

  EditEventUsecase({required EventRepository repository})
    : _repository = repository;

  @override
  Future<Either<Failure, EventEntity>> call(EditEventRequest request) async {
    try {
      return await _repository.editEvent(request);
    } catch (e) {
      return Left(
        Failure(
          message: 'EditEventUsecase - Failed to edit event: ${e.toString()}',
        ),
      );
    }
  }
}
