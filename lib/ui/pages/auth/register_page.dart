import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/bloc/auth/register/register_bloc.dart';
import 'package:flutter_frontend/models/request/register_request_model.dart';
import 'package:flutter_frontend/routes.dart';
import 'package:flutter_frontend/ui/widget/error_dialogs.dart';
import '../../../../../core/core.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          SizedBox(height: 260.0),
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20.0)),
                child: ColoredBox(
                  color: AppColors.spotifyGreen,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28.0, vertical: 44.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          controller: nameController,
                          label: 'Name',
                          isOutlineBorder: false,
                        ),
                        const SpaceHeight(20.0),
                        CustomTextField(
                          controller: emailController,
                          label: 'Email',
                          isOutlineBorder: false,
                        ),
                        const SpaceHeight(20.0),
                        CustomTextField(
                          controller: passwordController,
                          label: 'Password',
                          isOutlineBorder: false,
                          obscureText: true,
                        ),
                        const SpaceHeight(40.0),
                        BlocConsumer<RegisterBloc, RegisterState>(
                          listener: (context, state) {
                            if (state is RegisterSuccess) {
                              // Navigasi langsung tanpa login logic
                              Navigator.pushReplacementNamed(
                                  context, MyRoute.home.name);
                            } else if (state is RegisterError) {
                              // Tampilkan pesan kesalahan
                              showDialog(
                                  context: context,
                                  builder: (context) => ErrorDialog());
                            }
                          },
                          builder: (context, state) {
                            if (state is RegisterLoading) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return Button.filled(
                              onPressed: () {
                                // Navigasi langsung tanpa login logic
                                final requestBody = RegisterRequestModel(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                context
                                    .read<RegisterBloc>()
                                    .add(Register(requestBody));
                              },
                              label: 'Register',
                            );
                          },
                        ),
                        const SpaceHeight(128.0),
                        Center(
                          child: Text(
                            'have an account?',
                            style: TextStyle(color: AppColors.white),
                          ),
                        ),
                        const SpaceHeight(5.0),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              // Navigasi langsung tanpa login logic
                              Navigator.pushReplacementNamed(
                                  context, MyRoute.login.name);
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
