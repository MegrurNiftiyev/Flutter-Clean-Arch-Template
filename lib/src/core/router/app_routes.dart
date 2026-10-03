enum AppRoute {
  splash(path: '/'),
  onboarding(path: '/onboarding'),
  login(path: '/auth/login'),
  register(path: '/auth/register'),
  forgotPassword(path: '/auth/forgot-password'),
  verifyOtp(path: '/auth/verify-otp'),
  resetPassword(path: '/auth/reset-password'),
  home(path: '/home'),
  settings(path: '/settings');

  final String path;
  const AppRoute({required this.path});
}
