import 'package:personal_planner/app/modules/event/data/models/add_event_request.dart';
import 'package:personal_planner/app/modules/event/data/models/event_model.dart';

abstract class EventDatasource {
  Future<EventModel> addEvent(AddEventRequest request);
}
