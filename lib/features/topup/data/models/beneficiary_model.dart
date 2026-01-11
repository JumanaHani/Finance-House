import '../../domain/entities/beneficiary.dart';

class BeneficiaryModel {
  final String id;
  final String nickname;
  final String phoneNumber;
  final double monthlyTopUp;

  BeneficiaryModel({
    required this.id,
    required this.nickname,
    required this.phoneNumber,
    required this.monthlyTopUp,
  });

  factory BeneficiaryModel.fromEntity(Beneficiary entity) {
    return BeneficiaryModel(
      id: entity.id,
      nickname: entity.nickname,
      phoneNumber: entity.phoneNumber,
      monthlyTopUp: entity.monthlyTopUp,
    );
  }

  Beneficiary toEntity() {
    return Beneficiary(
      id: id,
      nickname: nickname,
      phoneNumber: phoneNumber,
      monthlyTopUp: monthlyTopUp,
    );
  }
}
