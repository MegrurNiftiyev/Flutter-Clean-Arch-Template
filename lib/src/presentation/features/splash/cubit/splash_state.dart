import 'package:equatable/equatable.dart';
import '../../../../core/enums/status.dart';

class SplashState extends Equatable {
  const SplashState({
    this.status = Status.Initial,
  });

  final Status status;

  SplashState copyWith({
    Status? status,
  }) {
    return SplashState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
