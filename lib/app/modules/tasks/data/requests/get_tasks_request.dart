import 'package:cloud_firestore/cloud_firestore.dart';

class GetTasksRequest {
  final DateTime? dateRangeStart;
  final DateTime? dateRangeEnd;
  final bool getOnlyPending;

  GetTasksRequest({
    this.dateRangeStart,
    this.dateRangeEnd,
    this.getOnlyPending = true,
  });

  toMap() {
    return {
      'date_range_start': dateRangeStart != null
          ? Timestamp.fromDate(dateRangeStart!)
          : null,
      'date_range_end': dateRangeEnd != null
          ? Timestamp.fromDate(dateRangeEnd!)
          : null,
      'get_only_pending': getOnlyPending,
    };
  }
}
