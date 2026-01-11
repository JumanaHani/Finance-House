import 'package:finance_house/features/topup/presentation/cubit/topup/topup_cubit.dart';
import 'package:finance_house/features/topup/presentation/cubit/topup/topup_state.dart';
import 'package:finance_house/features/topup/presentation/pages/add_beneficiary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/beneficiary_card.dart';

class TopUpPage extends StatefulWidget {
  const TopUpPage({super.key});

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  @override
  void initState() {
    super.initState();
    // Load data when page opens
    context.read<TopUpCubit>().loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Top Up')),
      body: BlocListener<TopUpCubit, TopUpState>(
        listener: (context, state) {
          if (state is TopUpError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is TopUpLoaded) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Top up successful')));
          }
        },
        child: BlocBuilder<TopUpCubit, TopUpState>(
          buildWhen: (previous, current) => current is! TopUpError,
          builder: (context, state) {
            if (state is TopUpLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is TopUpLoaded) {
              final user = state.user;
              final beneficiaries = state.beneficiaries;

              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Balance Card
                    Card(
                      child: ListTile(
                        title: const Text('Available Balance'),
                        trailing: Text(
                          'AED ${user.balance.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Beneficiaries Label
                    const Text(
                      'Beneficiaries',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Beneficiaries List
                    Expanded(
                      child: beneficiaries.isEmpty
                          ? const Center(
                              child: Text('No beneficiaries added yet'),
                            )
                          : ListView.builder(
                              itemCount: beneficiaries.length,
                              itemBuilder: (context, index) {
                                final beneficiary = beneficiaries[index];
                                return BeneficiaryCard(
                                  beneficiary: beneficiary,
                                );
                              },
                            ),
                    ),
                  ],
                ),
              );
            }

            // Default empty state
            return const SizedBox.shrink();
          },
        ),
      ),

      // Add Beneficiary FAB
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddBeneficiaryPage()),
          );
        },
        tooltip: 'Add Beneficiary',
        child: const Icon(Icons.add),
      ),
    );
  }
}
