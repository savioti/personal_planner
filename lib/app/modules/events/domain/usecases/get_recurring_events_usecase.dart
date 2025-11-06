import 'package:dartz/dartz.dart';
import 'package:personal_planner/app/modules/events/data/requests/get_recurring_events_request.dart';
import 'package:personal_planner/app/modules/events/domain/entities/event_entity.dart';
import 'package:personal_planner/app/modules/events/domain/repositories/event_repository.dart';
import 'package:personal_planner/app/shared/error/failure.dart';
import 'package:personal_planner/app/shared/usecase/async_usecase.dart';

class GetRecurringEventsUsecase
    extends AsyncUsecase<List<EventEntity>, GetRecurringEventsRequest> {
  final EventRepository _repository;

  GetRecurringEventsUsecase({required EventRepository repository})
    : _repository = repository;

  @override
  Future<Either<Failure, List<EventEntity>>> call(
    GetRecurringEventsRequest request,
  ) async {
    try {
      return await _repository.getRecurringEvents(request);
    } catch (e) {
      return Left(
        Failure(
          message:
              'GetRecurringEventsUsecase - Failed to get recurring event: ${e.toString()}',
        ),
      );
    }
  }
}
