class VerifyOtpResponse {
  final String resetToken;

  const VerifyOtpResponse({required this.resetToken});

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponse(
      resetToken: json['resetToken'] as String,
    );
  }

  Map<String, dynamic> toJson() => {'resetToken': resetToken};
}
