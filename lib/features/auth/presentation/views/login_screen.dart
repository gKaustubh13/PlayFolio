import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playfolio/features/auth/presentation/providers/auth_providers.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = true;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;
      final authNotifier = ref.read(authControllerProvider.notifier);

      if (_isLogin) {
        authNotifier.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authNotifier.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(authControllerProvider, (_, state) {
      if (state is AsyncError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(state.error.toString())));
      }
    });

    final authState = ref.watch(authControllerProvider);
    final isLoading = authState is AsyncLoading;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Welcome To PlayFolio',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  _isLogin ? 'Sign in to continue' : 'Create an account',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: isLoading ? null : _submit,
                  child: isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(_isLogin ? 'Sign In' : 'Sign Up'),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          ref
                              .read(authControllerProvider.notifier)
                              .signInAnonymously();
                        },
                  child: const Text('Continue as Guest'),
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                  child: Text(
                    _isLogin
                        ? 'Need an account? Sign Up'
                        : 'Have an account? Sign In',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
