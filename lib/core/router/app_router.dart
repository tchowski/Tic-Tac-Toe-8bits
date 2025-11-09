import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: StartRoute.page),
    AutoRoute(page: GameSelectionRoute.page),
    AutoRoute(page: GameRoute.page),
  ];
}
