// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:finance_house/features/topup/data/datasources/topup_remote_data_source.dart'
    as _i444;
import 'package:finance_house/features/topup/data/repositories/topup_repository_impl.dart'
    as _i650;
import 'package:finance_house/features/topup/domain/repositories/topup_repository.dart'
    as _i922;
import 'package:finance_house/features/topup/domain/usecases/add_beneficiary.dart'
    as _i12;
import 'package:finance_house/features/topup/domain/usecases/get_beneficiaries.dart'
    as _i795;
import 'package:finance_house/features/topup/domain/usecases/topup_beneficiary.dart'
    as _i107;
import 'package:finance_house/features/topup/presentation/cubit/topup/topup_cubit.dart'
    as _i414;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i444.TopUpRemoteDataSource>(
      () => _i444.TopUpRemoteDataSource(),
    );
    gh.lazySingleton<_i922.TopUpRepository>(
      () => _i650.TopUpRepositoryImpl(
        remoteDataSource: gh<_i444.TopUpRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i12.AddBeneficiary>(
      () => _i12.AddBeneficiary(gh<_i922.TopUpRepository>()),
    );
    gh.lazySingleton<_i795.GetBeneficiaries>(
      () => _i795.GetBeneficiaries(gh<_i922.TopUpRepository>()),
    );
    gh.lazySingleton<_i107.TopUpBeneficiary>(
      () => _i107.TopUpBeneficiary(gh<_i922.TopUpRepository>()),
    );
    gh.factory<_i414.TopUpCubit>(
      () => _i414.TopUpCubit(
        getBeneficiaries: gh<_i795.GetBeneficiaries>(),
        addBeneficiary: gh<_i12.AddBeneficiary>(),
        topUpBeneficiary: gh<_i107.TopUpBeneficiary>(),
      ),
    );
    return this;
  }
}
