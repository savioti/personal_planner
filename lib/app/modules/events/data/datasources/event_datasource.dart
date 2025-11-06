import 'package:personal_planner/app/modules/events/data/requests/add_event_request.dart';
import 'package:personal_planner/app/modules/events/data/models/event_model.dart';
import 'package:personal_planner/app/modules/events/data/requests/delete_event_request.dart';
import 'package:personal_planner/app/modules/events/data/requests/edit_event_request.dart';
import 'package:personal_planner/app/modules/events/data/requests/get_events_request.dart';
import 'package:personal_planner/app/modules/events/data/requests/get_recurring_events_request.dart';

abstract class EventDatasource {
  Future<EventModel> addEvent(AddEventRequest request);

  Future<List<EventModel>> getEvents(GetEventsRequest request);

  Future<bool> deleteEvent(DeleteEventRequest request);

  Future<EventModel> editEvent(EditEventRequest request);

  Future<List<EventModel>> getRecurringEvents(
    GetRecurringEventsRequest request,
  );
}
