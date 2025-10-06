import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:kitchen_queue/feautures/auth/presentation/signin_screen.dart';
import 'package:kitchen_queue/feautures/auth/presentation/signup_screen.dart';
import 'package:kitchen_queue/feautures/comment/presentation/comment_screen.dart';
import 'package:kitchen_queue/feautures/queue/presentation/queue_add_screen.dart';
import 'package:kitchen_queue/feautures/queue/presentation/queue_screen.dart';


class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) => SignUpScreen(),
      ),
      GoRoute(
        path: '/signin',
        builder: (BuildContext context, GoRouterState state) => SignInScreen(),
      ),
      GoRoute(
        path: '/queue',
        builder: (BuildContext context, GoRouterState state) => QueueScreen(),
        ),
      GoRoute(
        path: '/add',
        builder: (BuildContext context, GoRouterState state) => QueueAddScreen(), 
        ),
      GoRoute(
        path: '/comments',
        builder: (BuildContext context, GoRouterState state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final queueKey = extra['queueKey'] as String? ?? '';
          final userName = extra['userName'] as String? ?? '';
          final date = extra['date'] as DateTime? ?? DateTime.now();
          return CommentsScreen(
            queueKey: queueKey,
            userName: userName,
            date: date,
          );
        },
      ),
    ],
  );
}
  