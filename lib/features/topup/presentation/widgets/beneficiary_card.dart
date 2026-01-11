
import 'package:finance_house/features/topup/presentation/cubit/topup/topup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/amount_selector.dart';
import '../../domain/entities/beneficiary.dart';

class BeneficiaryCard extends StatefulWidget {
  final Beneficiary beneficiary;

  const BeneficiaryCard({super.key, required this.beneficiary});

  @override
  State<BeneficiaryCard> createState() => _BeneficiaryCardState();
}

class _BeneficiaryCardState extends State<BeneficiaryCard> {
  double? selectedAmount;

  final List<double> availableAmounts = const [
    5, 10, 20, 30, 50, 75, 100
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Beneficiary Info
            Text(
              widget.beneficiary.nickname,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(widget.beneficiary.phoneNumber),
            const SizedBox(height: 12),

            // Amount Selector
            AmountSelector(
              amounts: availableAmounts,
              onAmountSelected: (amount) {
                setState(() {
                  selectedAmount = amount;
                });
              },
            ),

            const SizedBox(height: 12),

            // Top Up Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: selectedAmount == null
                    ? null
                    : () {
                        context.read<TopUpCubit>().topUp(
                              widget.beneficiary,
                              selectedAmount!,
                            );
                        setState(() {
                          selectedAmount = null;
                        });
                      },
                child: const Text('Top Up'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
