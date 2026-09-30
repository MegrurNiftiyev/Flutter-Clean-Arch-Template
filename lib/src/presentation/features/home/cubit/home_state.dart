import 'package:equatable/equatable.dart';
import '../../../../core/enums/status.dart';

class HomeState extends Equatable {
  const HomeState({
    this.status = Status.Initial,
  });

  final Status status;

  HomeState copyWith({
    Status? status,
  }) {
    return HomeState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
