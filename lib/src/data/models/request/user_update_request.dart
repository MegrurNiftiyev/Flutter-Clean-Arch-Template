class UserUpdateRequest {
  const UserUpdateRequest({
    this.name,
  });

  final String? name;

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'fullName': name,
    };
  }
}
