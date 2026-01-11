import 'package:finance_house/core/error/failures.dart';
import 'package:finance_house/features/topup/domain/repositories/topup_repository.dart';
import 'package:injectable/injectable.dart';

import '../entities/beneficiary.dart';

@lazySingleton
class AddBeneficiary {
  final TopUpRepository repository;

  AddBeneficiary(this.repository);

  Future<void> call(Beneficiary beneficiary, int currentCount) {
    if (currentCount >= 5) {
      throw const BusinessFailure("Maximum 5 beneficiaries allowed");
    }

    if (beneficiary.nickname.length > 20) {
      throw const BusinessFailure("Nickname must be 20 characters or less");
    }

    return repository.addBeneficiary(beneficiary);
  }
}
