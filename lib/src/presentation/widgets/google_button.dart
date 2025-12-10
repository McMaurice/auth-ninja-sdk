import 'package:auth_ninja_sdk/auth_ninja_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GoogleLoginButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? textColor;
  final bool showText;
  final double size;

  GoogleLoginButton({
    super.key,
    this.text = "Continue with Google",
    this.borderRadius = 12,
    this.backgroundColor,
    this.textColor,
    this.showText = true,
    this.size = 56, this.onPressed,
  });

  final ninja = AuthNinja.instance;
  @override
  Widget build(BuildContext context) {
    final buttonContent = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "lib/assets/Google.svg",
          package: 'auth_ninja_sdk',
          width: 22,
          height: 22,
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(color: textColor ?? Colors.black87, fontSize: 16),
        ),
      ],
    );

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        elevation: 0,
        shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
        side: const BorderSide(
          color: Color.fromARGB(255, 226, 225, 225),
          width: 1,
        ),
      ),

      child: buttonContent,
    );
  }
}
