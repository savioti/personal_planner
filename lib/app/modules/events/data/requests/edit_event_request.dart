class EditEventRequest {
  final String eventId;
  final String title;
  final DateTime startTime;
  final DateTime? endTime;
  final String? description;

  EditEventRequest({
    required this.eventId,
    required this.title,
    required this.startTime,
    this.endTime,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'eventId': eventId,
      'title': title,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'description': description,
    };
  }
}
