import 'package:equatable/equatable.dart';
import '../../../../core/enums/status.dart';

class OnboardingState extends Equatable {
  const OnboardingState({
    this.status = Status.initial,
    this.currentPage = 0,
  });

  final Status status;
  final int currentPage;

  OnboardingState copyWith({
    Status? status,
    int? currentPage,
  }) {
    return OnboardingState(
      status: status ?? this.status,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [status, currentPage];
}
