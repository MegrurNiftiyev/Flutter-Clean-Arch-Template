class ResetPasswordRequest {
  final String resetToken;
  final String newPassword;

  const ResetPasswordRequest({
    required this.resetToken,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => {
        'resetToken': resetToken,
        'newPassword': newPassword,
      };
}
