import 'package:cloud_firestore/cloud_firestore.dart';

class GetEventsRequest {
  final DateTime dateRangeStart;
  final DateTime dateRangeEnd;

  GetEventsRequest({required this.dateRangeStart, required this.dateRangeEnd});

  toMap() {
    return {
      'date_range_start': Timestamp.fromDate(dateRangeStart),
      'date_range_end': Timestamp.fromDate(dateRangeEnd),
    };
  }
}
