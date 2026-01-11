import 'package:finance_house/features/topup/domain/entities/beneficiary.dart';
import 'package:finance_house/features/topup/domain/entities/user.dart';

class TopUpData {
  final User user;
  final List<Beneficiary> beneficiaries;

  const TopUpData({
    required this.user,
    required this.beneficiaries,
  });
}
