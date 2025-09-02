import 'package:personal_planner/app/modules/event/data/models/event_model.dart';

class EventEntity {
  final String id;
  final String title;
  final DateTime startTime;
  final DateTime? endTime;
  final String? description;

  EventEntity({
    required this.id,
    required this.title,
    required this.startTime,
    this.endTime,
    this.description,
  });

  @override
  String toString() {
    return 'EventEntity(id: $id, title: $title, startTime: $startTime, endTime: $endTime, description: $description)';
  }

  factory EventEntity.fromModel(EventModel model) {
    return EventEntity(
      id: model.id,
      title: model.title,
      startTime: model.startTime,
      endTime: model.endTime,
      description: model.description,
    );
  }
}
