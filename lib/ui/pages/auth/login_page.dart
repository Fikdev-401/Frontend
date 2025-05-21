import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/bloc/auth/login/login_bloc.dart';
import 'package:flutter_frontend/models/request/login_request_model.dart';
import 'package:flutter_frontend/routes.dart';
import 'package:flutter_frontend/utils/session_manager.dart';
import 'package:flutter_frontend/ui/widget/error_dialogs.dart';
import '../../../../../core/core.dart';

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

  void checkLoginSession() async {
    final token = await sessionManager.getToken();
    if (token.isNotEmpty) {
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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                // Spotify Logo
                Center(
                  child: Text(
                    'My Journal',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                // Login Header
                Text(
                  'Log in to My Journal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                // Social Login Buttons
                _buildSocialLoginButton(
                  icon: Icons.facebook,
                  label: 'CONTINUE WITH FACEBOOK',
                  color: Color(0xFF1877F2),
                ),
                const SizedBox(height: 12),
                _buildSocialLoginButton(
                  icon: Icons.apple,
                  label: 'CONTINUE WITH APPLE',
                  color: Colors.white,
                  textColor: Colors.black,
                ),
                const SizedBox(height: 12),
                _buildSocialLoginButton(
                  icon: Icons.g_mobiledata,
                  label: 'CONTINUE WITH GOOGLE',
                  color: Colors.white,
                  textColor: Colors.black,
                ),
                const SizedBox(height: 20),
                // OR Divider
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade800)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade800)),
                  ],
                ),
                const SizedBox(height: 20),
                // Email Field
                _buildTextField(
                  controller: emailController,
                  label: 'Email or username',
                ),
                const SizedBox(height: 16),
                // Password Field
                _buildTextField(
                  controller: passwordController,
                  label: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 12),
                // Forgot Password
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(50, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Forgot your password?',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Login Button with Remember Me
                Row(
                  children: [
                    // Remember Me Checkbox
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(
                        value: true,
                        onChanged: (value) {},
                        fillColor: MaterialStateProperty.all(AppColors.spotifyGreen),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Remember me',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    // Login Button
                    BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is LoginSuccess) {
                          redirectToHome();
                        } else if (state is LoginError) {
                          print(state.message);
                          showDialog(
                            context: context,
                            builder: (context) => ErrorDialog(),
                          );
                        }
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: state is LoginLoading
                              ? null
                              : () {
                                  final requestBody = LoginRequestModel(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                  context.read<LoginBloc>().add(Login(requestBody));
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.spotifyGreen,
                            foregroundColor: Colors.black,
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(16),
                            elevation: 0,
                          ),
                          child: state is LoginLoading
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.black,
                                  ),
                                )
                              : Icon(Icons.arrow_forward, size: 24),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                // Sign Up Section
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            MyRoute.register.name,
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 12,
                          ),
                          side: BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade800),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }

  Widget _buildSocialLoginButton({
    required IconData icon,
    required String label,
    required Color color,
    Color textColor = Colors.white,
  }) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 24),
      label: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        padding: EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        minimumSize: Size(double.infinity, 48),
        elevation: 0,
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
