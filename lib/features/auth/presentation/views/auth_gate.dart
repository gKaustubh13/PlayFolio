import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playfolio/features/auth/presentation/providers/auth_providers.dart';
import 'package:playfolio/features/auth/presentation/views/login_screen.dart';
import 'package:playfolio/features/home/presentation/views/home_screen.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangesProvider);

    return authState.when(
      data: (user) {
        if (user != null) {
          return const HomeScreen();
        } else{
          return const LoginScreen();
        }
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (err, stack) => Scaffold(
        body: Center(
          child: Text('Something went wrong: $err'),
        )
      )
    );
  }
}
