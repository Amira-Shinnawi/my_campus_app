import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/assignments/presentation/views/assignments_view.dart';
import '../../features/attendance/presentation/views/attendance_view.dart';
import '../../features/classes/presentation/views/classes_view.dart';
import '../../features/events/domain/entities/event_entity.dart';
import '../../features/events/presentation/views/event_details_view.dart';
import '../../features/events/presentation/views/events_view.dart';
import '../../features/home/presentation/view/campus_home_view.dart';
import '../../features/notices/domain/entities/notice_entity.dart';
import '../../features/notices/presentation/views/notice_details_view.dart';
import '../../features/notices/presentation/views/notices_list_view.dart';
import '../../features/messages/domain/entities/conversation_entity.dart';
import '../../features/messages/presentation/views/chat_view.dart';
import '../../features/messages/presentation/views/conversations_list_view.dart';
import '../../features/profile/presentation/views/profile_view.dart';
import '../../features/results/presentation/views/results_view.dart';

/// Central application router using GoRouter for declarative navigation.
abstract class AppRouter {
  /// Named route paths.
  static const String homePath = '/home';
  static const String assignmentsPath = '/assignments';
  static const String noticesPath = '/notices';
  static const String noticeDetailsPath = '/notices/details';
  static const String classesPath = '/classes';
  static const String attendancePath = '/attendance';
  static const String resultsPath = '/results';
  static const String eventsPath = '/events';
  static const String eventDetailsPath = '/events/details';
  static const String profilePath = '/profile';
  static const String messagesPath = '/messages';
  static const String chatPath = '/messages/chat';

  /// GoRouter configuration.
  static final GoRouter router = GoRouter(
    initialLocation: homePath,
    routes: <RouteBase>[
      GoRoute(
        path: homePath,
        builder: (BuildContext context, GoRouterState state) {
          return const CampusHomeView();
        },
      ),
      GoRoute(
        path: assignmentsPath,
        builder: (BuildContext context, GoRouterState state) {
          return const AssignmentsView();
        },
      ),
      GoRoute(
        path: noticesPath,
        builder: (BuildContext context, GoRouterState state) {
          return const NoticesListView();
        },
      ),
      GoRoute(
        path: noticeDetailsPath,
        builder: (BuildContext context, GoRouterState state) {
          final NoticeEntity notice = state.extra as NoticeEntity;
          return NoticeDetailsView(notice: notice);
        },
      ),
      GoRoute(
        path: classesPath,
        builder: (BuildContext context, GoRouterState state) {
          return const ClassesView();
        },
      ),
      GoRoute(
        path: attendancePath,
        builder: (BuildContext context, GoRouterState state) {
          return const AttendanceView();
        },
      ),
      GoRoute(
        path: resultsPath,
        builder: (BuildContext context, GoRouterState state) {
          return const ResultsView();
        },
      ),
      GoRoute(
        path: eventsPath,
        builder: (BuildContext context, GoRouterState state) {
          return const EventsView();
        },
      ),
      GoRoute(
        path: eventDetailsPath,
        builder: (BuildContext context, GoRouterState state) {
          final EventEntity event = state.extra as EventEntity;
          return EventDetailsView(event: event);
        },
      ),
      GoRoute(
        path: profilePath,
        builder: (BuildContext context, GoRouterState state) {
          return const ProfileView();
        },
      ),
      GoRoute(
        path: messagesPath,
        builder: (BuildContext context, GoRouterState state) {
          return const ConversationsListView();
        },
      ),
      GoRoute(
        path: chatPath,
        builder: (BuildContext context, GoRouterState state) {
          final ConversationEntity conversation =
              state.extra as ConversationEntity;
          return ChatView(conversation: conversation);
        },
      ),
    ],
  );
}





