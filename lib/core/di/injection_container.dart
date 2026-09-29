import 'package:get_it/get_it.dart';

import '../../features/assignments/data/datasources/assignments_local_data_source.dart';
import '../../features/assignments/data/repositories/assignments_repository_impl.dart';
import '../../features/assignments/domain/repositories/assignments_repository.dart';
import '../../features/assignments/domain/usecases/get_assignments.dart';
import '../../features/assignments/domain/usecases/update_assignment_status.dart';
import '../../features/assignments/presentation/cubit/assignments_cubit.dart';
import '../../features/attendance/data/datasources/attendance_local_data_source.dart';
import '../../features/attendance/data/repositories/attendance_repository_impl.dart';
import '../../features/attendance/domain/repositories/attendance_repository.dart';
import '../../features/attendance/domain/usecases/get_attendance_records.dart';
import '../../features/attendance/presentation/cubit/attendance_cubit.dart';
import '../../features/classes/data/datasources/classes_local_data_source.dart';
import '../../features/classes/data/repositories/classes_repository_impl.dart';
import '../../features/classes/domain/repositories/classes_repository.dart';
import '../../features/classes/domain/usecases/get_classes.dart';
import '../../features/classes/presentation/cubit/classes_cubit.dart';
import '../../features/events/data/datasources/events_local_data_source.dart';
import '../../features/events/data/repositories/events_repository_impl.dart';
import '../../features/events/domain/repositories/events_repository.dart';
import '../../features/events/domain/usecases/get_events.dart';
import '../../features/events/presentation/cubit/events_cubit.dart';
import '../../features/messages/data/datasources/messages_local_data_source.dart';
import '../../features/messages/data/repositories/messages_repository_impl.dart';
import '../../features/messages/domain/repositories/messages_repository.dart';
import '../../features/messages/domain/usecases/get_conversations.dart';
import '../../features/messages/domain/usecases/get_messages.dart';
import '../../features/messages/domain/usecases/send_message.dart';
import '../../features/messages/presentation/cubit/chat_cubit.dart';
import '../../features/messages/presentation/cubit/conversations_cubit.dart';
import '../../features/notices/data/datasources/notices_local_data_source.dart';
import '../../features/notices/data/repositories/notices_repository_impl.dart';
import '../../features/notices/domain/repositories/notices_repository.dart';
import '../../features/notices/domain/usecases/get_notices.dart';
import '../../features/notices/presentation/cubit/notices_cubit.dart';
import '../../features/profile/data/datasources/profile_local_data_source.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/domain/usecases/get_profile.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
import '../../features/results/data/datasources/results_local_data_source.dart';
import '../../features/results/data/repositories/results_repository_impl.dart';
import '../../features/results/domain/repositories/results_repository.dart';
import '../../features/results/domain/usecases/get_results.dart';
import '../../features/results/presentation/cubit/results_cubit.dart';

/// Global service locator instance.
final GetIt sl = GetIt.instance;

/// Initializes application dependencies and registers services, repositories,
/// use cases, and cubits.
Future<void> init() async {
  // Features - Profile
  sl.registerFactory(
    () => ProfileCubit(getProfile: sl()),
  );

  sl.registerLazySingleton(
    () => GetProfile(sl()),
  );

  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<ProfileLocalDataSource>(
    () => const ProfileLocalDataSourceImpl(),
  );

  // Features - Events
  sl.registerFactory(
    () => EventsCubit(getEvents: sl()),
  );

  sl.registerLazySingleton(
    () => GetEvents(sl()),
  );

  sl.registerLazySingleton<EventsRepository>(
    () => EventsRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<EventsLocalDataSource>(
    () => const EventsLocalDataSourceImpl(),
  );

  // Features - Assignments
  sl.registerFactory(
    () => AssignmentsCubit(
      getAssignments: sl(),
      updateAssignmentStatus: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetAssignments(sl()),
  );

  sl.registerLazySingleton(
    () => UpdateAssignmentStatus(sl()),
  );

  sl.registerLazySingleton<AssignmentsRepository>(
    () => AssignmentsRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<AssignmentsLocalDataSource>(
    () => AssignmentsLocalDataSourceImpl(),
  );

  // Features - Results
  sl.registerFactory(
    () => ResultsCubit(getResults: sl()),
  );

  sl.registerLazySingleton(
    () => GetResults(sl()),
  );

  sl.registerLazySingleton<ResultsRepository>(
    () => ResultsRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<ResultsLocalDataSource>(
    () => const ResultsLocalDataSourceImpl(),
  );

  // Features - Attendance
  sl.registerFactory(
    () => AttendanceCubit(getAttendanceRecords: sl()),
  );

  sl.registerLazySingleton(
    () => GetAttendanceRecords(sl()),
  );

  sl.registerLazySingleton<AttendanceRepository>(
    () => AttendanceRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<AttendanceLocalDataSource>(
    () => const AttendanceLocalDataSourceImpl(),
  );

  // Features - Classes
  sl.registerFactory(
    () => ClassesCubit(getClasses: sl()),
  );

  sl.registerLazySingleton(
    () => GetClasses(sl()),
  );

  sl.registerLazySingleton<ClassesRepository>(
    () => ClassesRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<ClassesLocalDataSource>(
    () => const ClassesLocalDataSourceImpl(),
  );

  // Features - Notices
  sl.registerFactory(
    () => NoticesCubit(getNotices: sl()),
  );

  sl.registerLazySingleton(
    () => GetNotices(sl()),
  );

  sl.registerLazySingleton<NoticesRepository>(
    () => NoticesRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<NoticesLocalDataSource>(
    () => const NoticesLocalDataSourceImpl(),
  );

  // Features - Messages
  sl.registerFactory(
    () => ConversationsCubit(getConversations: sl()),
  );

  sl.registerFactory(
    () => ChatCubit(
      getMessages: sl(),
      sendMessageUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetConversations(sl()),
  );

  sl.registerLazySingleton(
    () => GetMessages(sl()),
  );

  sl.registerLazySingleton(
    () => SendMessage(sl()),
  );

  sl.registerLazySingleton<MessagesRepository>(
    () => MessagesRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<MessagesLocalDataSource>(
    () => MessagesLocalDataSourceImpl(),
  );
}

