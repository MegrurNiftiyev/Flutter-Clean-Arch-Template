enum AppRoute {
  splash(path: '/'),
  onboarding(path: '/onboarding'),
  login(path: '/auth/login'),
  register(path: '/auth/register'),
  forgotPassword(path: '/auth/forgot-password'),
  verifyOtp(path: '/auth/verify-otp'),
  resetPassword(path: '/auth/reset-password'),
  home(path: '/home'),
  demoScreen1(path: '/demo-screen-1'),
  demoScreen2(path: '/demo-screen-2'),
  settings(path: '/settings');

  final String path;
  const AppRoute({required this.path});
}
