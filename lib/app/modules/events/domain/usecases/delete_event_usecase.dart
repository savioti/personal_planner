import 'package:dartz/dartz.dart';
import 'package:personal_planner/app/modules/events/data/requests/delete_event_request.dart';
import 'package:personal_planner/app/modules/events/domain/repositories/event_repository.dart';
import 'package:personal_planner/app/shared/error/failure.dart';
import 'package:personal_planner/app/shared/usecase/async_usecase.dart';

class DeleteEventUsecase extends AsyncUsecase<bool, DeleteEventRequest> {
  final EventRepository _repository;

  DeleteEventUsecase({required EventRepository repository})
    : _repository = repository;

  @override
  Future<Either<Failure, bool>> call(DeleteEventRequest request) async {
    try {
      return await _repository.deleteEvent(request);
    } catch (e) {
      return Left(
        Failure(
          message:
              'DeleteEventUsecase - Failed to delete event: ${e.toString()}',
        ),
      );
    }
  }
}
