import 'package:fan2dev/core/core.dart';
import 'package:fan2dev/features/about/about.dart';
import 'package:fan2dev/features/auth/auth.dart';
import 'package:fan2dev/features/backoffice/backoffice.dart';
import 'package:fan2dev/features/blog/blog.dart';
import 'package:fan2dev/features/contact/contact.dart';
import 'package:fan2dev/features/home/home.dart';
import 'package:fan2dev/features/projects/projects.dart';
import 'package:fan2dev/features/settings/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

/// Initializes and returns an instance of [GoRouter]
/// configured with the specified
///
/// The initialLocation parameter specifies the initial route
/// location when the application starts.
///
/// The routes parameter defines the available routes in the application.
/// Each route is defined using a [GoRoute] object.
///
/// The path property of [GoRoute] specifies the path for the route.
///
/// The builder property of [GoRoute] is a callback function that builds the
/// corresponding widget for the route. It receives the `context`
/// and `state` parameters.
///
/// The routes property of [GoRoute] is an optional parameter that allows
/// nesting additional routes under the parent route.
///
final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/blog',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state, child) => NoTransitionPage(
        child: HomePage(
          child: child,
        ),
      ),
      routes: [
        GoRoute(
          path: '/',
          parentNavigatorKey: _shellNavigatorKey,
          redirect: (context, state) => '/blog',
        ),
        GoRoute(
          path: '/blog',
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: BlogHomePage(),
          ),
        ),
        GoRoute(
          path: '/projects',
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ProjectsHomePage(),
          ),
          routes: [
            GoRoute(
              path: ':id',
              parentNavigatorKey: _shellNavigatorKey,
              redirect: (context, state) {
                final extra = state.extra;
                final possibleProject = extra as ProjectsProject?;

                if (possibleProject != null) {
                  return null;
                }

                final projectParamId = state.pathParameters['id']!;
                final id = int.tryParse(projectParamId);

                if (id == null) {
                  return '/projects';
                }

                final result = locator<LocalDataSourceImpl>().getProjectById(
                  id,
                );

                ProjectsProject? project;

                result.when(
                  success: (project) {
                    project = project;
                  },
                  failure: (failure) {
                    project = null;
                  },
                  empty: () {
                    project = null;
                  },
                );

                if (project == null) {
                  return '/projects';
                }

                return null;
              },
              pageBuilder: (context, state) {
                final extra = state.extra;
                final possibleProject = extra as ProjectsProject?;

                if (possibleProject != null) {
                  return NoTransitionPage(
                    child: ProjectsProjectDetailPage(project: possibleProject),
                  );
                }

                final projectParamId = state.pathParameters['id']!;
                final id = int.tryParse(projectParamId);

                if (id == null) {
                  return const NoTransitionPage(
                    child: ProjectsHomePage(),
                  );
                }

                final result = locator<LocalDataSourceImpl>().getProjectById(
                  id,
                );

                ProjectsProject? project;

                result.when(
                  success: (project) {
                    project = project;
                  },
                  failure: (failure) {
                    project = null;
                  },
                  empty: () {
                    project = null;
                  },
                );

                if (project == null) {
                  return const NoTransitionPage(
                    child: ProjectsHomePage(),
                  );
                }

                return NoTransitionPage(
                  child: ProjectsProjectDetailPage(project: project!),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: '/about',
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: AboutHomePage(),
          ),
        ),
        GoRoute(
          path: '/contact',
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) => NoTransitionPage(
            child: ContactHomePage(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/log-in',
      parentNavigatorKey: _rootNavigatorKey,
      redirect: (context, state) {
        final auth = FirebaseAuth.instance;

        if (auth.currentUser != null) {
          return '/backoffice';
        } else {
          return null;
        }
      },
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/settings',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SettingsHomePage(),
      routes: [
        GoRoute(
          path: 'language',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const SettingsLanguagePage(),
        ),
        GoRoute(
          path: 'theme',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const SettingsThemePage(),
        ),
      ],
    ),
    GoRoute(
      path: '/backoffice',
      parentNavigatorKey: _rootNavigatorKey,
      redirect: (context, state) {
        final auth = FirebaseAuth.instance;

        if (auth.currentUser == null) {
          return '/log-in';
        } else {
          return null;
        }
      },
      builder: (context, state) => const BackofficeHomePage(),
    ),
  ],
);
