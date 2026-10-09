import '../../../domain/models/user_model.dart';

class UserDto {
  final String id;
  final String email;
  final String? name;

  const UserDto({
    required this.id,
    required this.email,
    this.name,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['fullName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': name,
    };
  }

  UserModel toDomain() {
    return UserModel(
      id: id,
      email: email,
      name: name,
    );
  }
}
