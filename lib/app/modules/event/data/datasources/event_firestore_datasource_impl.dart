import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_planner/app/modules/event/data/datasources/event_datasource.dart';
import 'package:personal_planner/app/modules/event/data/models/add_event_request.dart';
import 'package:personal_planner/app/modules/event/data/models/event_model.dart';

class EventFirestoreDatasourceImpl implements EventDatasource {
  EventFirestoreDatasourceImpl({FirebaseFirestore? firestore})
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
      throw Exception('Firestore error [${e.code}]: ${e.message}');
    } catch (e) {
      throw Exception('EventFirestoreDatasourceImpl.addEvent: $e');
    }
  }
}
