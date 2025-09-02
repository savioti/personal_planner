import 'package:personal_planner/app/modules/event/data/requests/add_event_request.dart';
import 'package:personal_planner/app/modules/event/data/models/event_model.dart';
import 'package:personal_planner/app/modules/event/data/requests/delete_event_request.dart';
import 'package:personal_planner/app/modules/event/data/requests/get_events_request.dart';

abstract class EventDatasource {
  Future<EventModel> addEvent(AddEventRequest request);

  Future<List<EventModel>> getEvents(GetEventsRequest request);

  Future<bool> deleteEvent(DeleteEventRequest request);
}
