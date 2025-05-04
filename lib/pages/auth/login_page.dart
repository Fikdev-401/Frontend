import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/bloc/auth/login/login_bloc.dart';
import 'package:flutter_frontend/models/login_request_model.dart';
import 'package:flutter_frontend/routes.dart';
import 'package:flutter_frontend/utils/session_manager.dart';
import 'package:flutter_frontend/widget/error_dialogs.dart';
import '../../../../core/core.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final sessionManager = SessionManager();

  void redirectToHome() {
    Navigator.pushReplacementNamed(context, MyRoute.home.name);
  }

  void checkLoginSession() async{
    final token = await sessionManager.getToken();
    if(token.isNotEmpty){
      redirectToHome();
    }
  }

  @override
  void initState() {
    checkLoginSession();
    super.initState();
  }

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
                          controller: emailController,
                          label: 'Email',
                          isOutlineBorder: false,
                        ),
                        const SpaceHeight(36.0),
                        CustomTextField(
                          controller: passwordController,
                          label: 'Password',
                          isOutlineBorder: false,
                          obscureText: true,
                        ),
                        const SpaceHeight(86.0),
                        BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) {
                            if (state is LoginSuccess) {
                              // Navigasi langsung tanpa login logic
                              redirectToHome();
                            } else if (state is LoginError) {
                              print(state.message);
                              // Tampilkan pesan kesalahan
                              showDialog(
                                  context: context,
                                  builder: (context) => ErrorDialog());
                            }
                          },
                          builder: (context, state) {
                            if (state is LoginLoading) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return Button.filled(
                              onPressed: () {
                                // Navigasi langsung tanpa login logic
                                final requestBody = LoginRequestModel(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                context
                                    .read<LoginBloc>()
                                    .add(Login(requestBody));
                              },
                              label: 'Login',
                            );
                          },
                        ),
                        const SpaceHeight(128.0),
                        Center(
                          child: Text(
                            'Don\'t have an account?',
                            style: TextStyle(color: AppColors.white),
                          ),
                        ),
                        const SpaceHeight(5.0),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, MyRoute.register.name);
                            },
                            child: Text(
                              'Sign Up',
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
