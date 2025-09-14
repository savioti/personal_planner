import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_planner/app/modules/tasks/data/datasources/tasks_datasource.dart';
import 'package:personal_planner/app/modules/tasks/data/models/task_model.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/add_task_request.dart';
import 'package:personal_planner/app/modules/tasks/data/requests/get_tasks_request.dart';

class TasksFirestoreDatasourceImpl implements TasksDatasource {
  TasksFirestoreDatasourceImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Future<TaskModel> addTask(AddTaskRequest request) async {
    try {
      final col = _firestore.collection('tasks');
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

      return TaskModel.fromMap({...data, 'id': docRef.id});
    } on FirebaseException catch (e) {
      throw Exception(
        'TasksFirestoreDatasourceImpl.addTask - Firestore error [${e.code}]: ${e.message}',
      );
    } catch (e) {
      throw Exception('TasksFirestoreDatasourceImpl.addTask: $e');
    }
  }

  @override
  Future<List<TaskModel>> getTasks(GetTasksRequest request) async {
    try {
      final col = _firestore.collection('tasks');
      Query<Map<String, dynamic>> query = col;

      if (request.dateRangeStart != null) {
        query = query.where(
          'deadline',
          isGreaterThanOrEqualTo: Timestamp.fromDate(request.dateRangeStart!),
        );
      }

      if (request.dateRangeEnd != null) {
        query = query.where(
          'deadline',
          isLessThanOrEqualTo: Timestamp.fromDate(request.dateRangeEnd!),
        );
      }

      if (request.getOnlyPending) {
        query = query.where('is_done', isEqualTo: false);
      }

      final querySnap = await query.get();
      final tasks = <TaskModel>[];

      for (final docSnap in querySnap.docs) {
        final data = docSnap.data();
        tasks.add(TaskModel.fromMap({...data, 'id': docSnap.id}));
      }

      return tasks;
    } on FirebaseException catch (e) {
      throw Exception(
        'TasksFirestoreDatasourceImpl.getTasks - Firestore error [${e.code}]: ${e.message}',
      );
    } catch (e) {
      throw Exception('TasksFirestoreDatasourceImpl.getTasks: $e');
    }
  }
}
