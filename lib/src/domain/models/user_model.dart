import 'base/base_model.dart';
import 'base/timestamp_model.dart';

class UserModel extends BaseModel implements TimestampModel {
  const UserModel({
    required super.id,
    required this.email,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  final String email;
  final String? name;

  @override
  final DateTime? createdAt;

  @override
  final DateTime? updatedAt;
}
