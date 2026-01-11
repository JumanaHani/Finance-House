import 'package:finance_house/core/error/failures.dart';
import 'package:finance_house/features/topup/domain/repositories/topup_repository.dart';
import 'package:injectable/injectable.dart';

import '../entities/beneficiary.dart';
import '../entities/user.dart';
@lazySingleton
class TopUpBeneficiary {
  final TopUpRepository repository;

  TopUpBeneficiary(this.repository);

  Future<void> call({
    required User user,
    required Beneficiary beneficiary,
    required double amount,
  }) async {
    const transactionFee = 3.0;

    final totalAmount = amount + transactionFee;

    if (totalAmount > user.balance) {
      throw const BusinessFailure("Insufficient balance");
    }

    final beneficiaryLimit = user.isVerified ? 1000 : 500;

    if (beneficiary.monthlyTopUp + amount > beneficiaryLimit) {
      throw const BusinessFailure("Beneficiary monthly limit exceeded");
    }

    if (user.monthlyTotalTopUp + amount > 3000) {
      throw const BusinessFailure("Total monthly limit exceeded");
    }

    await repository.topUp(beneficiary.id, amount);
  }
}
