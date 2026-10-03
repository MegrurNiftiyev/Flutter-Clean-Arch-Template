extension StringValidatorExtensions on String? {
  bool get isNullOrEmpty => this == null || this!.trim().isEmpty;

  bool get isValidEmail {
    if (isNullOrEmpty) return false;
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    return emailRegExp.hasMatch(this!.trim());
  }

  bool get isValidPassword {
    if (isNullOrEmpty) return false;
    return this!.trim().length >= 6;
  }

  String? validateEmail({String? emptyMessage, String? invalidMessage}) {
    if (isNullOrEmpty) return emptyMessage ?? 'Email is required';
    if (!isValidEmail) return invalidMessage ?? 'Enter a valid email';
    return null;
  }

  String? validatePassword({String? emptyMessage, String? invalidMessage}) {
    if (isNullOrEmpty) return emptyMessage ?? 'Password is required';
    if (!isValidPassword) {
      return invalidMessage ?? 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateRequired([String? emptyMessage]) {
    if (isNullOrEmpty) return emptyMessage ?? 'This field is required';
    return null;
  }
}
