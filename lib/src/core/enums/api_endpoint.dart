enum ApiEndpoint {
  login('/auth/login', requiresAuth: false),
  register('/auth/register', requiresAuth: false),
  forgotPassword('/auth/forgot-password', requiresAuth: false),
  verifyOtp('/auth/verify-otp', requiresAuth: false),
  resetPassword('/auth/reset-password', requiresAuth: false),
  refreshToken('/auth/refresh', requiresAuth: false),
  userProfile('/user/profile');

  final String path;
  final bool requiresAuth;

  const ApiEndpoint(this.path, {this.requiresAuth = true});

  static final _publicPaths = {
    for (final e in values)
      if (!e.requiresAuth) e.path,
  };

  static bool isPublic(String path) => _publicPaths.contains(path);
}
