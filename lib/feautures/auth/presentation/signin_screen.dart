import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kitchen_queue/feautures/auth/blocs/auth_cubit.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Авторизация')),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message))
            );

          } else if (state is AuthAuthenticated) {
            context.go('/queue');
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                   
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText:'Пароль' ),
                    obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    state is AuthLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                          onPressed: () {
                              context.read<AuthCubit>().signIn(
                                _emailController.text.trim(), 
                                _passwordController.text.trim(),
                                );
                            
                          }, 
                          child: const Text('Войти')),

                          TextButton(
                    onPressed: () {
                      context.go('/');
                    },
                    child: Text('Нет аккаунта. Зарегистрироваться', style: TextStyle(color: Colors.grey)),
                  ),
                          
                ]
              ),)
            );
        }, 
        )
    );
  }
}