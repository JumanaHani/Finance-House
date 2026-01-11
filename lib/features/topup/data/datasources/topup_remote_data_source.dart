import 'package:finance_house/core/error/exceptions.dart';
import 'package:injectable/injectable.dart';

import '../models/user_model.dart';
import '../models/beneficiary_model.dart';

@lazySingleton
class TopUpRemoteDataSource {
  // Simulated backend storage
  final List<BeneficiaryModel> _beneficiaries = [];
  UserModel _user = UserModel(
    balance: 600,
    isVerified: false,
    monthlyTotalTopUp: 300,
  );
  final bool _hasInternet = true; // to simulate offline
  Future<UserModel> fetchUser() async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (!_hasInternet) {
      throw const NetworkException();
    }
    return _user;
  }

  Future<List<BeneficiaryModel>> fetchBeneficiaries() async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (!_hasInternet) {
      throw const NetworkException();
    }
    return List.unmodifiable(_beneficiaries);
  }

  Future<void> addBeneficiary(BeneficiaryModel model) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (!_hasInternet) {
      throw const NetworkException();
    }
    _beneficiaries.add(model);
  }

  Future<void> topUp(String beneficiaryId, double amount) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (!_hasInternet) {
      throw const NetworkException();
    }
    final index = _beneficiaries.indexWhere((b) => b.id == beneficiaryId);

    if (index == -1) {
      throw const NotFoundException('Beneficiary not found');
    }

    final beneficiary = _beneficiaries[index];

    _beneficiaries[index] = BeneficiaryModel(
      id: beneficiary.id,
      nickname: beneficiary.nickname,
      phoneNumber: beneficiary.phoneNumber,
      monthlyTopUp: beneficiary.monthlyTopUp + amount,
    );

    _user = UserModel(
      balance: _user.balance - amount - 3, // transaction fee
      isVerified: _user.isVerified,
      monthlyTotalTopUp: _user.monthlyTotalTopUp + amount,
    );
  }
}
