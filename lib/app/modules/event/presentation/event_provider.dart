import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_planner/app/infra/dependency_injection/service_locator.dart';
import 'package:personal_planner/app/modules/event/domain/entities/event_entity.dart';
import 'package:personal_planner/app/modules/event/domain/utils/event_utils.dart';
import 'package:personal_planner/app/modules/event/presentation/event_controller.dart';
import 'package:personal_planner/app/shared/classes/range.dart';

final eventProvider = Provider<EventController>((ref) {
  return serviceLocator<EventController>();
});

final currentWeekDateRangeProvider = Provider<Range<DateTime>>((ref) {
  final today = DateTime.now();
  return EventUtils.getWeekDateRange(today);
});

final weekEventsProvider =
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
