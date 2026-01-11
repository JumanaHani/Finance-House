import 'package:equatable/equatable.dart';

import '../../../domain/entities/beneficiary.dart';
import '../../../domain/entities/user.dart';

abstract class TopUpState extends Equatable {
  const TopUpState();

  @override
  List<Object?> get props => [];
}

class TopUpInitial extends TopUpState {}

class TopUpLoading extends TopUpState {}

class TopUpLoaded extends TopUpState {
  final User user;
  final List<Beneficiary> beneficiaries;

  const TopUpLoaded(this.user, this.beneficiaries);
}

class TopUpError extends TopUpState {
  final String message;

  const TopUpError(this.message);
}
