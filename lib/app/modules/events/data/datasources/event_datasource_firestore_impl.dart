import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_planner/app/modules/events/data/datasources/event_datasource.dart';
import 'package:personal_planner/app/modules/events/data/requests/add_event_request.dart';
import 'package:personal_planner/app/modules/events/data/models/event_model.dart';
import 'package:personal_planner/app/modules/events/data/requests/delete_event_request.dart';
import 'package:personal_planner/app/modules/events/data/requests/get_events_request.dart';

class EventDatasourceFirestoreImpl implements EventDatasource {
  EventDatasourceFirestoreImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Future<EventModel> addEvent(AddEventRequest request) async {
    try {
      final col = _firestore.collection('events');
      final docRef = col.doc();
      final now = DateTime.now().toUtc();

      final payload = <String, dynamic>{
        'id': docRef.id,
        ...request.toMap(),
        'created_at': Timestamp.fromDate(now),
        'updated_at': Timestamp.fromDate(now),
      };

      await docRef.set(payload);

      final snap = await docRef.get();
      final data = snap.data();

      if (data == null) {
        throw StateError('Empty document ${docRef.path}');
      }

      return EventModel.fromMap({...data, 'id': docRef.id});
    } on FirebaseException catch (e) {
      throw Exception(
        'EventFirestoreDatasourceImpl.addEvent - Firestore error [${e.code}]: ${e.message}',
      );
    } catch (e) {
      throw Exception('EventFirestoreDatasourceImpl.addEvent: $e');
    }
  }

  @override
  Future<List<EventModel>> getEvents(GetEventsRequest request) async {
    try {
      final col = _firestore.collection('events');

      final querySnap = await col
          .where(
            'start_time',
            isGreaterThanOrEqualTo: Timestamp.fromDate(request.dateRangeStart),
          )
          .where(
            'start_time',
            isLessThanOrEqualTo: Timestamp.fromDate(request.dateRangeEnd),
          )
          .orderBy('start_time')
          .get();

      final events = <EventModel>[];

      for (final docSnap in querySnap.docs) {
        final data = docSnap.data();
        events.add(EventModel.fromMap({...data, 'id': docSnap.id}));
      }

      return events;
    } on FirebaseException catch (e) {
      throw Exception(
        'EventFirestoreDatasourceImpl.getEvents - Firestore error [${e.code}]: ${e.message}',
      );
    } catch (e) {
      throw Exception('EventFirestoreDatasourceImpl.getEvents: $e');
    }
  }

  @override
  Future<bool> deleteEvent(DeleteEventRequest request) async {
    try {
      final docRef = _firestore.collection('events').doc(request.eventId);
      final docSnap = await docRef.get();

      if (!docSnap.exists) {
        throw StateError('Document not found: ${docRef.path}');
      }

      await docRef.delete();
      return true;
    } on FirebaseException catch (e) {
      throw Exception(
        'EventFirestoreDatasourceImpl.deleteEvent - Firestore error [${e.code}]: ${e.message}',
      );
    } catch (e) {
      throw Exception('EventFirestoreDatasourceImpl.deleteEvent: $e');
    }
  }
}
