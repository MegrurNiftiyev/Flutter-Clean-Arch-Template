import 'package:equatable/equatable.dart';

abstract class BaseException extends Equatable implements Exception {
  final String message;
  final int? statusCode;

  const BaseException(this.message, [this.statusCode]);

  @override
  List<Object?> get props => [message, statusCode];

  @override
  String toString() => '$runtimeType($statusCode): $message';
}
