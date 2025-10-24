import 'package:get_it/get_it.dart';
import 'package:personal_planner/app/modules/events/data/datasources/event_datasource.dart';
import 'package:personal_planner/app/modules/events/data/datasources/event_datasource_firestore_impl.dart';
import 'package:personal_planner/app/modules/events/data/repositories/event_repository_impl.dart';
import 'package:personal_planner/app/modules/events/domain/repositories/event_repository.dart';
import 'package:personal_planner/app/modules/events/domain/usecases/add_event_usecase.dart';
import 'package:personal_planner/app/modules/events/domain/usecases/delete_event_usecase.dart';
import 'package:personal_planner/app/modules/events/domain/usecases/edit_event_usecase.dart';
import 'package:personal_planner/app/modules/events/domain/usecases/get_events_usecase.dart';
import 'package:personal_planner/app/modules/events/presentation/event_controller.dart';
import 'package:personal_planner/app/modules/tasks/data/datasources/tasks_datasource.dart';
import 'package:personal_planner/app/modules/tasks/data/datasources/tasks_firestore_datasource_impl.dart';
import 'package:personal_planner/app/modules/tasks/data/repositories/tasks_repository_impl.dart';
import 'package:personal_planner/app/modules/tasks/domain/repositories/tasks_repository.dart';
import 'package:personal_planner/app/modules/tasks/domain/usecases/add_task_usecase.dart';
import 'package:personal_planner/app/modules/tasks/domain/usecases/complete_task_usecase.dart';
import 'package:personal_planner/app/modules/tasks/domain/usecases/delete_task_usecase.dart';
import 'package:personal_planner/app/modules/tasks/domain/usecases/get_all_pending_tasks_usecase.dart';
import 'package:personal_planner/app/modules/tasks/domain/usecases/get_backlog_tasks_request_usecase.dart';
import 'package:personal_planner/app/modules/tasks/domain/usecases/get_overdue_tasks_usecase.dart';
import 'package:personal_planner/app/modules/tasks/domain/usecases/get_tasks_usecase.dart';
import 'package:personal_planner/app/modules/tasks/presentation/tasks_controller.dart';

final serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  _registerDataSources();
  _registerRepositories();
  _registerUseCases();
  _registerControllers();
}

void _registerDataSources() {
  serviceLocator.registerLazySingleton<EventDatasource>(
    () => EventDatasourceFirestoreImpl(),
  );
  serviceLocator.registerLazySingleton<TasksDatasource>(
    () => TasksFirestoreDatasourceImpl(),
  );
}

void _registerRepositories() {
  serviceLocator.registerLazySingleton<EventRepository>(
    () => EventRepositoryImpl(datasource: serviceLocator.get()),
  );
  serviceLocator.registerLazySingleton<TasksRepository>(
    () => TasksRepositoryImpl(datasource: serviceLocator.get()),
  );
}

void _registerUseCases() {
  serviceLocator.registerLazySingleton<AddEventUsecase>(
    () => AddEventUsecase(repository: serviceLocator.get()),
  );
  serviceLocator.registerLazySingleton<GetEventsUsecase>(
    () => GetEventsUsecase(repository: serviceLocator.get()),
  );
  serviceLocator.registerLazySingleton<DeleteEventUsecase>(
    () => DeleteEventUsecase(repository: serviceLocator.get()),
  );
  serviceLocator.registerLazySingleton<AddTaskUsecase>(
    () => AddTaskUsecase(repository: serviceLocator.get()),
  );
  serviceLocator.registerLazySingleton<GetTasksUsecase>(
    () => GetTasksUsecase(repository: serviceLocator.get()),
  );
  serviceLocator.registerLazySingleton<GetAllPendingTasksUsecase>(
    () => GetAllPendingTasksUsecase(repository: serviceLocator.get()),
  );
  serviceLocator.registerLazySingleton<GetBacklogTasksRequestUsecase>(
    () => GetBacklogTasksRequestUsecase(serviceLocator.get()),
  );
  serviceLocator.registerLazySingleton<CompleteTaskUsecase>(
    () => CompleteTaskUsecase(repository: serviceLocator.get()),
  );
  serviceLocator.registerLazySingleton<DeleteTaskUsecase>(
    () => DeleteTaskUsecase(repository: serviceLocator.get()),
  );
  serviceLocator.registerLazySingleton<GetOverdueTasksUsecase>(
    () => GetOverdueTasksUsecase(repository: serviceLocator.get()),
  );
  serviceLocator.registerLazySingleton<EditEventUsecase>(
    () => EditEventUsecase(repository: serviceLocator.get()),
  );
}

void _registerControllers() {
  serviceLocator.registerLazySingleton<EventController>(
    () => EventController(
      addEventUsecase: serviceLocator.get(),
      getEventsUsecase: serviceLocator.get(),
      deleteEventUsecase: serviceLocator.get(),
      editEventUsecase: serviceLocator.get(),
    ),
  );
  serviceLocator.registerLazySingleton<TasksController>(
    () => TasksController(
      addTaskUsecase: serviceLocator.get(),
      getTasksUsecase: serviceLocator.get(),
      getAllPendingTasksUsecase: serviceLocator.get(),
      getBacklogTasksRequestUsecase: serviceLocator.get(),
      completeTaskUsecase: serviceLocator.get(),
      deleteTaskUsecase: serviceLocator.get(),
      getOverdueTasksUsecase: serviceLocator.get(),
    ),
  );
}
