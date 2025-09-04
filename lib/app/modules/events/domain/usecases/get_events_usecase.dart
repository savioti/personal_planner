import 'package:dartz/dartz.dart';
import 'package:personal_planner/app/modules/events/data/requests/get_events_request.dart';
import 'package:personal_planner/app/modules/events/domain/entities/event_entity.dart';
import 'package:personal_planner/app/modules/events/domain/repositories/event_repository.dart';
import 'package:personal_planner/app/shared/error/failure.dart';
import 'package:personal_planner/app/shared/usecase/async_usecase.dart';

class GetEventsUsecase
    extends AsyncUsecase<List<EventEntity>, GetEventsRequest> {
  final EventRepository _repository;

  GetEventsUsecase({required EventRepository repository})
    : _repository = repository;

  @override
  Future<Either<Failure, List<EventEntity>>> call(
    GetEventsRequest request,
  ) async {
    try {
      return await _repository.getEvents(request);
    } catch (e) {
      return Left(
        Failure(
          message: 'GetEventsUsecase - Failed to add event: ${e.toString()}',
        ),
      );
    }
  }
}
