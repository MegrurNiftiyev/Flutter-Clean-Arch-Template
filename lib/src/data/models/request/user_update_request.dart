class UserUpdateRequest {
  const UserUpdateRequest({
    required this.userId,
    this.name,
  });

  final String userId;
  final String? name;

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      if (name != null) 'name': name,
    };
  }
}
