import 'package:finance_house/features/topup/domain/entities/topup_data.dart';
import 'package:finance_house/features/topup/domain/repositories/topup_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton

class GetBeneficiaries {
  final TopUpRepository repository;

  GetBeneficiaries(this.repository);

  Future<TopUpData> call() async {
    final user = await repository.getUser();
    final beneficiaries = await repository.getBeneficiaries();

    return TopUpData(
      user: user,
      beneficiaries: beneficiaries,
    );
  }
}
