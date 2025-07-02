import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newshive/views/widgets/forgot_password_screen.dart';
import 'package:newshive/views/widgets/login_screen.dart';
import 'package:newshive/views/widgets/main_screen.dart';
import 'package:newshive/views/widgets/register_screen.dart';
import 'package:newshive/views/widgets/splash_screen.dart';
import '../routes/route_names.dart';

class AppRouter {
  AppRouter._();

  static final AppRouter _instance = AppRouter._();
  static AppRouter get instance => _instance;

  factory AppRouter() {
    _instance.goRouter = goRouterSetup();
    return _instance;
  }

  GoRouter? goRouter;

  static GoRouter goRouterSetup() {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          name: RouteNames.splash,
          pageBuilder: (_, __) => const MaterialPage(child: SplashScreen()),
        ),
        GoRoute(
          path: '/login',
          name: RouteNames.login,
          pageBuilder: (_, __) => const MaterialPage(child: LoginScreen()),
        ),
        GoRoute(
          path: '/register',
          name: RouteNames.register,
          pageBuilder: (_, __) => const MaterialPage(child: RegisterScreen()),
        ),
        GoRoute(
          path: '/forgot-password',
          name: RouteNames.forgotPassword,
          pageBuilder:
              (_, __) => const MaterialPage(child: ForgotPasswordScreen()),
        ),
        GoRoute(
          path: '/main',
          name: RouteNames.main,
          pageBuilder: (_, __) => const MaterialPage(child: MainScreen()),
        ),
      ],
    );
  }
}
