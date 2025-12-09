import 'package:auth_ninja_sdk/src/presentation/widgets/apple_button.dart';
import 'package:auth_ninja_sdk/src/presentation/widgets/google_button.dart';
import 'package:flutter/material.dart';

class SocialLoginSection extends StatelessWidget {
  final bool showGoogle;
  final bool showApple;
  final bool isRow; 
  final double spacing; 
  final bool googleShowText; 
  final bool appleShowText; 
  final bool googleCircular; 
  final bool appleCircular; 
  final double circularSize; 
  final Color? googleBackground;
  final Color? applebackground;
  final VoidCallback? onGooglePressed;
  final VoidCallback? onApplePressed;

  const SocialLoginSection({
    super.key,
    this.showGoogle = true,
    this.showApple = true,
    this.isRow = false,
    this.spacing = 10,
    this.googleShowText = true,
    this.appleShowText = true,
    this.googleCircular = false,
    this.appleCircular = false,
    this.circularSize = 56,
    this.onGooglePressed,
    this.onApplePressed,
    this.googleBackground,
    this.applebackground,
  });

  @override
  Widget build(BuildContext context) {
    final buttons = <Widget>[];

    if (showGoogle) {
      buttons.add(GoogleLoginButton(
        showText: googleShowText,
        isCircular: googleCircular,
        size: circularSize,
        onPressed: onGooglePressed,
        backgroundColor: googleBackground ??Colors.white,
      ));
    }

    if (showApple) {
      buttons.add(AppleLoginButton(
        showText: appleShowText,
        isCircular: appleCircular,
        size: circularSize,
        onPressed: onApplePressed,
        backgroundColor: applebackground ??Colors.white,
      ));
    }

    if (buttons.isEmpty) return const SizedBox.shrink();

    return isRow
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buttons
                .map((b) => Padding(
                      padding: EdgeInsets.only(right: b != buttons.last ? spacing : 0),
                      child: b,
                    ))
                .toList(),
          )
        : Column(
            children: buttons
                .map((b) => Padding(
                      padding: EdgeInsets.only(bottom: b != buttons.last ? spacing : 0),
                      child: b,
                    ))
                .toList(),
          );
  }
}