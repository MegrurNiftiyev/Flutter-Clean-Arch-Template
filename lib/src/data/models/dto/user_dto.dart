import '../../../domain/models/user_model.dart';

class UserDto {
  final String id;
  final String email;
  final String? name;
  final String? role;
  final bool isActive;

  const UserDto({
    required this.id,
    required this.email,
    this.name,
    this.role,
    this.isActive = true,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['fullName'] as String?,
      role: json['role'] as String?,
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': name,
      'role': role,
      'isActive': isActive,
    };
  }

  UserModel toDomain() {
    return UserModel(
      id: id,
      email: email,
      name: name,
      role: role,
      isActive: isActive,
    );
  }
}
