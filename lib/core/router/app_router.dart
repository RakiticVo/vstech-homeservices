import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/widgets/placeholder_page.dart';

/// Root GoRouter config. Auth guards belong here as `redirect` callbacks — never as
/// widget-level conditions (see CLAUDE.md Authentication rules). Route-level BLoCs are wrapped
/// with `BlocProvider` inside each route's `builder`, not at the app root.
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const PlaceholderPage(label: 'VSTech Home Services'),
    ),
    // Feature routes are added here as they're scaffolded — see flutter-feature-scaffold skill.
  ],
);
