import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../auth/authentication_bloc.dart';

// pages
import '../pages/login_page.dart';
import '../pages/main_scaffold.dart';
import '../pages/profile_page.dart';
import '../pages/list_page.dart';
import '../pages/detail_page.dart';

import '../model/book.dart';

class AppRouter {
  final AuthenticationBloc authBloc;

  AppRouter({required this.authBloc}); // Constructor to inject the AuthenticationBloc

  late final GoRouter router = GoRouter(
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) {
      final isLoggedIn = context.read<AuthenticationBloc>().state.isLoggedIn;
      final loggingIn = state.location == '/login';

      if (!isLoggedIn && !loggingIn) {
        return '/login';
      }
      if (isLoggedIn && loggingIn) {
        return '/';
      }
      return null;
    },
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainScaffold(child: child),
        routes: [
          GoRoute(
            path: '/',
            name: 'home', // add a name to the home route
            redirect: (_, __) => '/byAuthor',
          ),
          GoRoute(
            path: '/byAuthor',
            name: 'byAuthor',
            builder: (context, state) => ListPage(),
            routes: [
              GoRoute(
                path: 'detail',
                name: 'byAuthorDetail',
                builder: (context, state) {
                  final book = state.extra as Book; // query parameter
                  return ByDetailPage(book: book);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/byTitle',
            name: 'byTitle',
            builder: (context, state) => ListPage(),
            routes: [
              GoRoute(
                path: 'detail',
                name: 'byTitleDetail',
                builder: (context, state) {
                  final book = state.extra as Book; // query parameter
                  return ByDetailPage(book: book);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) => ProfilePage(),
          ),
        ],
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => LoginPage(),
      ),
    ],
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream stream) {
    stream.listen((_) {
      notifyListeners();
    });
  }
}
