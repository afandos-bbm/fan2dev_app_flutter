import 'package:fan2dev/core/auth_service/auth_service.dart';
import 'package:fan2dev/core/core.dart';
import 'package:fan2dev/core/firebase_client/firebase_client.dart';
import 'package:fan2dev/features/about/about.dart';
import 'package:fan2dev/features/app/privacy_policy/view/privacy_policy_page.dart';
import 'package:fan2dev/features/auth/auth.dart';
import 'package:fan2dev/features/auth/view/register_page.dart';
import 'package:fan2dev/features/backoffice/backoffice.dart';
import 'package:fan2dev/features/blog/blog.dart';
import 'package:fan2dev/features/blog/data/data_sources/blog_firestore_remote_data_source.dart';
import 'package:fan2dev/features/blog/domain/domain.dart';
import 'package:fan2dev/features/blog/view/blog_post_detail_page.dart';
import 'package:fan2dev/features/contact/contact.dart';
import 'package:fan2dev/features/home/home.dart';
import 'package:fan2dev/features/onboarding/view/ob_notifications_page.dart';
import 'package:fan2dev/features/onboarding/view/ob_posts_page.dart';
import 'package:fan2dev/features/onboarding/view/ob_welcome_page.dart';
import 'package:fan2dev/features/profile/view/profile_home_page.dart';
import 'package:fan2dev/features/projects/projects.dart';
import 'package:fan2dev/features/settings/settings.dart';
import 'package:fan2dev/features/settings/view/settings_notifications.dart';
import 'package:fan2dev/utils/logger.dart';
import 'package:fan2dev/utils/result.dart';
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
final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/onboarding/1',
  observers: [_NavigationLoggerObserver()],
  errorBuilder: (context, state) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      router.go('/');
    });

    return const SizedBox.shrink();
  },
  redirect: (context, state) {
    final hasDoneOnboarding =
        locator<SharedPreferencesService>().hasDoneOnboarding;

    final isOnboardingRoute = state.uri.pathSegments.contains('onboarding');

    if (!hasDoneOnboarding && !isOnboardingRoute) {
      return '/onboarding/1';
    }

    if (hasDoneOnboarding && isOnboardingRoute) {
      return '/';
    }

    return null;
  },
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => HomePage(
        child: child,
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
          routes: [
            GoRoute(
              path: ':id',
              parentNavigatorKey: _shellNavigatorKey,
              redirect: (context, state) async {
                final extra = state.extra;
                final possiblePost = extra as BlogPost?;

                if (possiblePost != null) {
                  return null;
                }

                final postParamId = state.pathParameters['id']!;
                final id = int.tryParse(postParamId);

                if (id == null) {
                  return '/blog';
                }

                final result =
                    await locator<BlogFirestoreRemoteDataSource>().getPostById(
                  id: id.toString(),
                );

                BlogPost? post;

                result.when(
                  success: (post) {
                    post = post;
                  },
                  failure: (failure) {
                    post = null;
                  },
                  empty: () {
                    post = null;
                  },
                );

                if (post == null) {
                  return '/blog';
                }

                return null;
              },
              pageBuilder: (context, state) {
                final extra = state.extra;
                final possiblePost = extra as BlogPost?;

                if (possiblePost != null) {
                  return NoTransitionPage(
                    child: BlogPostDetailPage(
                      post: Future.value(
                        Result<BlogPost, Exception>.success(
                          data: possiblePost,
                        ),
                      ),
                    ),
                  );
                }

                final postParamId = state.pathParameters['id']!;
                final id = int.tryParse(postParamId);

                if (id == null) {
                  return const NoTransitionPage(
                    child: BlogHomePage(),
                  );
                }

                final result =
                    locator<BlogFirestoreRemoteDataSource>().getPostById(
                  id: id.toString(),
                );

                return NoTransitionPage(
                  child: BlogPostDetailPage(post: result),
                );
              },
            ),
          ],
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
        final auth = locator<FirebaseClient>().firebaseAuthInstance;

        if (auth.currentUser != null) {
          return '/profile';
        } else {
          return null;
        }
      },
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      parentNavigatorKey: _rootNavigatorKey,
      redirect: (context, state) {
        final auth = locator<FirebaseClient>().firebaseAuthInstance;

        if (auth.currentUser != null) {
          return '/backoffice';
        } else {
          return null;
        }
      },
      builder: (context, state) => RegisterPage(),
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
        GoRoute(
          path: 'notifications',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const SettingsNotificationsPage(),
        ),
      ],
    ),
    GoRoute(
      path: '/backoffice',
      parentNavigatorKey: _rootNavigatorKey,
      redirect: (context, state) {
        final auth = locator<FirebaseClient>().firebaseAuthInstance;

        if (auth.currentUser == null) {
          return '/';
        } else {
          if (locator<AuthService>().isAdmin!) {
            return null;
          } else {
            return '/profile';
          }
        }
      },
      builder: (context, state) => const BackofficeHomePage(),
    ),
    GoRoute(
      path: '/profile',
      parentNavigatorKey: _rootNavigatorKey,
      redirect: (context, state) {
        final auth = locator<FirebaseClient>().firebaseAuthInstance;

        if (auth.currentUser == null) {
          return '/';
        } else {
          return null;
        }
      },
      builder: (context, state) => const ProfileHomePage(),
    ),
    GoRoute(
      path: '/privacy-policy',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const PrivacyPolicyPage(),
    ),
    GoRoute(
      path: '/onboarding/1',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ObWelcomePage(),
    ),
    GoRoute(
      path: '/onboarding/2',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ObPostsPage(),
    ),
    GoRoute(
      path: '/onboarding/3',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ObNotificationsPage(),
    ),
  ],
);

class _NavigationLoggerObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    l(route.settings.name ?? 'Pushed Non routed Scaffold', name: '🔜 Pushed');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    l(route.settings.name ?? 'Pushed Non routed Scaffold', name: '🔙 Popped');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    l(route.settings.name ?? 'Pushed Non routed Scaffold', name: '🗑 Removed');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    l(
      newRoute?.settings.name ?? 'Pushed Non routed Scaffold',
      name: '🔄 Replaced',
    );
  }
}
