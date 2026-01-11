import 'package:finance_house/core/error/failures.dart';
import 'package:finance_house/features/topup/domain/entities/beneficiary.dart';
import 'package:finance_house/features/topup/domain/entities/user.dart';
import 'package:finance_house/features/topup/domain/usecases/add_beneficiary.dart';
import 'package:finance_house/features/topup/domain/usecases/get_beneficiaries.dart';
import 'package:finance_house/features/topup/domain/usecases/topup_beneficiary.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'topup_state.dart';

@injectable
class TopUpCubit extends Cubit<TopUpState> {
  final GetBeneficiaries getBeneficiaries;
  final AddBeneficiary addBeneficiary;
  final TopUpBeneficiary topUpBeneficiary;

  User? _currentUser;
  List<Beneficiary>? _currentBeneficiary;
  TopUpCubit({
    required this.getBeneficiaries,
    required this.addBeneficiary,
    required this.topUpBeneficiary,
  }) : super(TopUpInitial());

  Future<void> loadData() async {
    emit(TopUpLoading());
    try {
      final data = await getBeneficiaries();
      _currentUser = data.user;
      _currentBeneficiary = data.beneficiaries;
      emit(TopUpLoaded(data.user, data.beneficiaries));
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> addNewBeneficiary(Beneficiary beneficiary) async {
    try {
      await addBeneficiary(beneficiary, _currentBeneficiary?.length ?? 0);

      final updatedList = List<Beneficiary>.from(_currentBeneficiary ?? [])
        ..add(beneficiary);

      emit(TopUpLoaded(_currentUser!, updatedList));
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> topUp( Beneficiary beneficiary, double amount) async {
    if (_currentUser == null) return;
    try {
      await topUpBeneficiary(
        user: _currentUser!,
        beneficiary: beneficiary,
        amount: amount,
      );
      await loadData();
    } catch (e) {
      _handleError(e);
    }
  }

  void _handleError(Object error) {
    if (error is Failure) {
      emit(TopUpError(error.message));
    } else {
      emit(TopUpError('Unexpected error occurred'));
    }
  }
}
