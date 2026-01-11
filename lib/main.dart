import 'package:finance_house/features/topup/presentation/cubit/topup/topup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection_container.dart';
import 'features/topup/presentation/pages/topup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TopUpCubit>(),
      child: MaterialApp(
        title: 'UAE Top Up',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const TopUpPage(),
      ),
    );
  }
}
