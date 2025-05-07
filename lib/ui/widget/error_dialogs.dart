import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/colors.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.backgroundDark,
      title: Text(
        'Login Failed',
        style: TextStyle(color: AppColors.white),
      ),
      content: Text(
        'Your username or password is incorrect',
        style: TextStyle(color: AppColors.white),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Close'),
        ),
      ],
    );
  }
}
