import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/features/auth/view/pages/forgot_password_page.dart';
import '../../presentation/features/auth/view/pages/login_page.dart';
import '../../presentation/features/auth/view/pages/register_page.dart';
import '../../presentation/features/auth/view/pages/reset_password_page.dart';
import '../../presentation/features/auth/view/pages/verify_otp_page.dart';
import '../../presentation/features/demo_screen1/view/pages/demo_screen1_page.dart';
import '../../presentation/features/demo_screen2/view/pages/demo_screen2_page.dart';
import '../../presentation/features/error/view/pages/error_page.dart';
import '../../presentation/features/home/view/pages/home_page.dart';
import '../../presentation/features/onboarding/view/pages/onboarding_page.dart';
import '../../presentation/features/settings/view/pages/settings_page.dart';
import '../../presentation/features/splash/view/pages/splash_page.dart';
import 'app_routes.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoute.splash.path,
    routes: [
      GoRoute(
        path: AppRoute.splash.path,
        name: AppRoute.splash.name,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoute.onboarding.path,
        name: AppRoute.onboarding.name,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: AppRoute.login.path,
        name: AppRoute.login.name,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: AppRoute.register.path,
        name: AppRoute.register.name,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const RegisterPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: AppRoute.forgotPassword.path,
        name: AppRoute.forgotPassword.name,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ForgotPasswordPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(
                Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                    .chain(CurveTween(curve: Curves.easeInOut)),
              ),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: AppRoute.verifyOtp.path,
        name: AppRoute.verifyOtp.name,
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return VerifyOtpPage(email: email);
        },
      ),
      GoRoute(
        path: AppRoute.resetPassword.path,
        name: AppRoute.resetPassword.name,
        builder: (context, state) {
          final extra = state.extra as Map<String, String>? ?? {};
          return ResetPasswordPage(
            email: extra['email'] ?? '',
            resetToken: extra['resetToken'] ?? '',
          );
        },
      ),
      GoRoute(
        path: AppRoute.home.path,
        name: AppRoute.home.name,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoute.demoScreen1.path,
        name: AppRoute.demoScreen1.name,
        builder: (context, state) => const DemoScreen1Page(),
      ),
      GoRoute(
        path: AppRoute.demoScreen2.path,
        name: AppRoute.demoScreen2.name,
        builder: (context, state) => const DemoScreen2Page(),
      ),
      GoRoute(
        path: AppRoute.settings.path,
        name: AppRoute.settings.name,
        builder: (context, state) => const SettingsPage(),
      ),
    ],
    errorBuilder: (context, state) => ErrorPage(
      error: state.error?.message ?? 'No route defined for ${state.uri}',
    ),
  );
}
