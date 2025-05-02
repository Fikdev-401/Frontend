import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/core.dart';

import 'login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () => context.pushReplacement(LoginPage()),
    );
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Padding(
        padding: const EdgeInsets.all(96.0),
        child: Center(
          child: Text(
            'My Journal App',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              
            ),
          ),
        ),
      ),
    );
  }
}
