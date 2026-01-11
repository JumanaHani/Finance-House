import 'package:bloc_test/bloc_test.dart';
import 'package:finance_house/features/topup/domain/entities/topup_data.dart';
import 'package:finance_house/features/topup/presentation/cubit/topup/topup_cubit.dart';
import 'package:finance_house/features/topup/presentation/cubit/topup/topup_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:finance_house/core/error/failures.dart';
import 'package:finance_house/features/topup/domain/entities/beneficiary.dart';
import 'package:finance_house/features/topup/domain/entities/user.dart';
import 'package:finance_house/features/topup/domain/usecases/add_beneficiary.dart';
import 'package:finance_house/features/topup/domain/usecases/get_beneficiaries.dart';
import 'package:finance_house/features/topup/domain/usecases/topup_beneficiary.dart';

class BeneficiaryFake extends Fake implements Beneficiary {}

// -------------------- Mock Classes --------------------
class MockGetBeneficiaries extends Mock implements GetBeneficiaries {}

class MockAddBeneficiary extends Mock implements AddBeneficiary {}

class MockTopUpBeneficiary extends Mock implements TopUpBeneficiary {}

// -------------------- Main --------------------
void main() {
  late TopUpCubit cubit;
  late MockGetBeneficiaries mockGetBeneficiaries;
  late MockAddBeneficiary mockAddBeneficiary;
  late MockTopUpBeneficiary mockTopUpBeneficiary;

  // Test Data
  final user = User(isVerified: false, balance: 100, monthlyTotalTopUp: 100);
  final beneficiary1 = Beneficiary(
    id: 'b1',
    nickname: 'Mom',
    phoneNumber: '0790000000',
    monthlyTopUp: 100,
  );

  final beneficiariesResponse = TopUpData(
    user: user,
    beneficiaries: [beneficiary1],
  );
  setUpAll(() {
    registerFallbackValue(BeneficiaryFake());
  });
  setUp(() {
    mockGetBeneficiaries = MockGetBeneficiaries();
    mockAddBeneficiary = MockAddBeneficiary();
    mockTopUpBeneficiary = MockTopUpBeneficiary();

    cubit = TopUpCubit(
      getBeneficiaries: mockGetBeneficiaries,
      addBeneficiary: mockAddBeneficiary,
      topUpBeneficiary: mockTopUpBeneficiary,
    );
  });

  // -------------------- loadData Tests --------------------
  blocTest<TopUpCubit, TopUpState>(
    'emits [TopUpLoading, TopUpLoaded] when loadData succeeds',
    build: () {
      when(
        () => mockGetBeneficiaries(),
      ).thenAnswer((_) async => beneficiariesResponse);
      return cubit;
    },
    act: (cubit) => cubit.loadData(),
    expect: () => [
      TopUpLoading(),
      TopUpLoaded(user, [beneficiary1]),
    ],
  );

  blocTest<TopUpCubit, TopUpState>(
    'emits [TopUpLoading, TopUpError] when loadData fails',
    build: () {
      when(() => mockGetBeneficiaries()).thenThrow(ServerFailure());
      return cubit;
    },
    act: (cubit) => cubit.loadData(),
    expect: () => [TopUpLoading(), TopUpError('Server error')],
  );

  // -------------------- addNewBeneficiary Tests --------------------
  blocTest<TopUpCubit, TopUpState>(
    'adds a new beneficiary and emits updated list',
    build: () {
      when(
        () => mockGetBeneficiaries(),
      ).thenAnswer((_) async => beneficiariesResponse);
      when(() => mockAddBeneficiary(any(), any())).thenAnswer((_) async {});
      return cubit;
    },
    act: (cubit) async {
      await cubit.loadData();
      await cubit.addNewBeneficiary(
        Beneficiary(
          id: 'b2',
          nickname: 'Dad',
          phoneNumber: '0780000000',
          monthlyTopUp: 0,
        ),
      );
    },
    expect: () => [
      TopUpLoading(),

      TopUpLoaded(user, [
        beneficiary1,
        Beneficiary(
          id: 'b2',
          nickname: 'Dad',
          phoneNumber: '0780000000',
          monthlyTopUp: 0,
        ),
      ]),
    ],
  );

  blocTest<TopUpCubit, TopUpState>(
    'emits TopUpError when addNewBeneficiary fails due to business rule',
    build: () {
      when(
        () => mockAddBeneficiary(any(), any()),
      ).thenThrow(BusinessFailure('Maximum 5 beneficiaries allowed'));
      return cubit;
    },
    act: (cubit) async {
      await cubit.addNewBeneficiary(beneficiary1);
    },
    expect: () => [TopUpError('Maximum 5 beneficiaries allowed')],
  );

}
