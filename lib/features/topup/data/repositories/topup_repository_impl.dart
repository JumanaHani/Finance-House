import 'package:finance_house/core/error/exceptions.dart';
import 'package:finance_house/core/error/failures.dart';
import 'package:finance_house/features/topup/data/datasources/topup_remote_data_source.dart';
import 'package:finance_house/features/topup/data/models/beneficiary_model.dart';
import 'package:finance_house/features/topup/domain/entities/beneficiary.dart';
import 'package:finance_house/features/topup/domain/entities/user.dart';
import 'package:finance_house/features/topup/domain/repositories/topup_repository.dart';
import 'package:injectable/injectable.dart';


@LazySingleton(as: TopUpRepository)
class TopUpRepositoryImpl implements TopUpRepository {
  final TopUpRemoteDataSource remoteDataSource;

  TopUpRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<User> getUser() async {
    try {
      final userModel = await remoteDataSource.fetchUser();
      return userModel.toEntity();
    } on NetworkException {
      throw const NetworkFailure();
    } on ServerException {
      throw const ServerFailure();
    } catch (_) {
      throw const ServerFailure();
    }
  }

  @override
  Future<List<Beneficiary>> getBeneficiaries() async {
    try {
      final models = await remoteDataSource.fetchBeneficiaries();
      return models.map((m) => m.toEntity()).toList();
    } on NetworkException {
      throw const NetworkFailure();
    } on ServerException {
      throw const ServerFailure();
    } catch (_) {
      throw const ServerFailure();
    }
  }

  @override
  Future<void> addBeneficiary(Beneficiary beneficiary) async {
    try {
      final model = BeneficiaryModel.fromEntity(beneficiary);
      await remoteDataSource.addBeneficiary(model);
    } on NetworkException {
      throw const NetworkFailure();
    } on ServerException catch (e) {
      throw BusinessFailure(e.message);
    } catch (_) {
      throw const ServerFailure();
    }
  }

  @override
  Future<void> topUp(String beneficiaryId, double amount) async {
    try {
      await remoteDataSource.topUp(beneficiaryId, amount);
    } on NetworkException {
      throw const NetworkFailure();
    } on NotFoundException catch (e) {
      throw BusinessFailure(e.message);
    } catch (_) {
      throw const ServerFailure();
    }
  }
}
