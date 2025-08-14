import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playfolio/features/auth/presentation/providers/auth_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateChangesProvider).value;
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlayFolio Home'),
        actions: [
          IconButton(
            onPressed: ref.read(authControllerProvider.notifier).signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Welcome!\nUID : ${user?.uid}\nIs Anonymous: ${user?.isAnonymous}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
