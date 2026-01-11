import 'package:finance_house/features/topup/domain/entities/beneficiary.dart';
import 'package:finance_house/features/topup/presentation/cubit/topup/topup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBeneficiaryPage extends StatefulWidget {
  const AddBeneficiaryPage({super.key});

  @override
  State<AddBeneficiaryPage> createState() => _AddBeneficiaryPageState();
}

class _AddBeneficiaryPageState extends State<AddBeneficiaryPage> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nicknameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      final beneficiary = Beneficiary(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nickname: _nicknameController.text,
      phoneNumber: _phoneController.text,
      monthlyTopUp: 0,
    );

    context.read<TopUpCubit>().addNewBeneficiary(beneficiary);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Beneficiary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 24),

              /// Avatar
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blue.shade100,
                child: const Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.blue,
                ),
              ),

              const SizedBox(height: 32),

              /// Nickname
              TextFormField(
                controller: _nicknameController,
                maxLength: 20,
                decoration: const InputDecoration(
                  labelText: 'Nickname',
                  hintText: 'Enter nickname (max 20 characters)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nickname is required';
                  }
                  if (value.length > 20) {
                    return 'Maximum 20 characters allowed';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              /// Phone Number
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  hintText: '+971 5X XXX XXXX',
                  prefixText: '+971 ',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Phone number is required';
                  }
                  if (value.length < 8) {
                    return 'Invalid phone number';
                  }
                  return null;
                },
              ),

              const Spacer(),

              /// Save Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _onSave,
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
