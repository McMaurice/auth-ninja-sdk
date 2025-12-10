import 'package:auth_ninja_sdk/src/presentation/widgets/apple_button.dart';
import 'package:auth_ninja_sdk/src/presentation/widgets/google_button.dart';
import 'package:flutter/material.dart';

class SocialLoginSection extends StatelessWidget {
  final Color? googleBackground;
  final Color? applebackground;
  final VoidCallback? onGooglePressed;
  final VoidCallback? onApplePressed;
  final bool? isLoading;

  const SocialLoginSection({
    super.key,
    this.onGooglePressed,
    this.onApplePressed,
    this.googleBackground,
    this.applebackground,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {


    return Column(children: [
      GoogleLoginButton(
        onPressed:onGooglePressed,
       
      ),
      SizedBox(height: 10),
      AppleLoginButton(
        onPressed: onApplePressed,
      ),
    ],);
}
}