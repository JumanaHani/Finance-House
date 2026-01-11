import 'package:finance_house/features/topup/domain/entities/beneficiary.dart';
import 'package:finance_house/features/topup/domain/entities/user.dart';

abstract class TopUpRepository {
  Future<User> getUser();
  Future<List<Beneficiary>> getBeneficiaries();

  Future<void> addBeneficiary(Beneficiary beneficiary);

  Future<void> topUp(
    String beneficiaryId,
    double amount,
  );
}
