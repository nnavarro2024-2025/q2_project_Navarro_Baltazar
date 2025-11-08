import 'package:edc_v2/features/auth/presentation/page/auth_page.dart';
import 'package:edc_v2/features/main/presentation/page/main_page.dart';
import 'package:edc_v2/features/main/presentation/page/single_application_page.dart';
import 'package:edc_v2/features/main/presentation/page/payment_page.dart';
import 'package:edc_v2/features/main/presentation/page/donate_application_page.dart';
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
    ,
    GoRoute(
      path: '/application/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return SingleApplicationPage(applicationId: id);
      }
    ),
    GoRoute(
      path: '/payment/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return PaymentPage(applicationId: id);
      }
    ),
    GoRoute(
      path: '/donate-device/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return DonateApplicationPage(applicationId: id);
      }
    )
  ]);
}