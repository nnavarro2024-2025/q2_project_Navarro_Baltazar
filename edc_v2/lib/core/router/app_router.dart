import 'package:edc_v2/features/auth/presentation/page/auth_page.dart';
import 'package:edc_v2/features/main/presentation/page/main_page.dart';
import 'package:edc_v2/splash_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static var router = GoRouter(initialLocation: AuthPage.path,routes: [
      GoRoute(
      path: SplashPage.path,
      builder: (context, state) {
        return SplashPage();
      }
    ),
    GoRoute(
      path: AuthPage.path,
      builder: (context, state) {
        return AuthPage();
      }
    ),
        GoRoute(
      path: MainPage.path,
      builder: (context, state) {
        return MainPage();
      }
    )
  ]);
}