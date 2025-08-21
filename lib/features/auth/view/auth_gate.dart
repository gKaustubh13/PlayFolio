import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playfolio/core/providers.dart';
import 'package:playfolio/features/auth/view/login_screen.dart';
import 'package:playfolio/features/auth/view/widgets/auth_error_screen.dart';
import 'package:playfolio/features/auth/view/widgets/auth_loading_screen.dart';
import 'package:playfolio/features/home/views/home_screen.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangesProvider);

    return authState.when(
      data: (user) {
        if (user != null) {
          return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      },
      loading: () => const AuthLoadingScreen(),
      error: (error, stackTree) => AuthErrorScreen(
        error: error,
        onRetry: () {
          ref.invalidate(authStateChangesProvider);
        },
      ),
    );
  }
}
