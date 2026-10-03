class VerifyOtpRequest {
  final String email;
  final String otpCode;

  const VerifyOtpRequest({
    required this.email,
    required this.otpCode,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'otpCode': otpCode,
      };
}
