enum ApiEndpoint {
  login('/api/v1/auth/login', requiresAuth: false),
  register('/api/v1/auth/register', requiresAuth: false),
  forgotPassword('/api/v1/auth/forgot-password', requiresAuth: false),
  verifyOtp('/api/v1/auth/verify-otp', requiresAuth: false),
  resetPassword('/api/v1/auth/change-password', requiresAuth: false),
  refreshToken('/api/v1/auth/refresh', requiresAuth: false),
  logout('/api/v1/auth/logout'),
  userProfile('/api/v1/users/me');

  final String path;
  final bool requiresAuth;

  const ApiEndpoint(this.path, {this.requiresAuth = true});

  static final _publicPaths = {
    for (final e in values)
      if (!e.requiresAuth) e.path,
  };

  static bool isPublic(String path) => _publicPaths.contains(path);
}
