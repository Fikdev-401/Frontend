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
                // Register Header
                Text(
                  'Sign up for free to start writing',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                // Social Register Buttons
                _buildSocialButton(
                  icon: Icons.facebook,
                  label: 'SIGN UP WITH FACEBOOK',
                  color: Color(0xFF1877F2),
                ),
                const SizedBox(height: 12),
                _buildSocialButton(
                  icon: Icons.g_mobiledata,
                  label: 'SIGN UP WITH GOOGLE',
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
                // Sign up with email header
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sign up with your email address',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Name Field
                _buildTextField(
                  controller: nameController,
                  label: 'What\'s your name?',
                ),
                const SizedBox(height: 16),
                // Email Field
                _buildTextField(
                  controller: emailController,
                  label: 'What\'s your email?',
                ),
                const SizedBox(height: 16),
                // Password Field
                _buildTextField(
                  controller: passwordController,
                  label: 'Create a password',
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                // Terms and Conditions
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                    children: [
                      TextSpan(
                        text: 'By clicking on sign-up, you agree to My Journal\'s ',
                      ),
                      TextSpan(
                        text: 'Terms and Conditions of Use',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(text: '.'),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                    children: [
                      TextSpan(
                        text: 'To learn more about how My Journal collects, uses, shares and protects your personal data, please see ',
                      ),
                      TextSpan(
                        text: 'My Journal\'s Privacy Policy',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(text: '.'),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Register Button
                BlocConsumer<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterSuccess) {
                      Navigator.pushReplacementNamed(
                        context, 
                        MyRoute.home.name
                      );
                    } else if (state is RegisterError) {
                      showDialog(
                        context: context,
                        builder: (context) => ErrorDialog(),
                      );
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state is RegisterLoading
                          ? null
                          : () {
                              final requestBody = RegisterRequestModel(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              context
                                  .read<RegisterBloc>()
                                  .add(Register(requestBody));
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.spotifyGreen,
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: Size(double.infinity, 48),
                        elevation: 0,
                      ),
                      child: state is RegisterLoading
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.black,
                              ),
                            )
                          : Text(
                              'SIGN UP',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                    );
                  },
                ),
                const SizedBox(height: 32),
                // Login Section
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Have an account?',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            MyRoute.login.name,
                          );
                        },
                        child: Text(
                          'Log in',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
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

  Widget _buildSocialButton({
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
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
