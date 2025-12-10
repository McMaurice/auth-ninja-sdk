import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppleLoginButton extends ConsumerWidget {
  final String text;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? textColor;
  final bool showText;
  final double size;
  final VoidCallback? onPressed;

  const AppleLoginButton({
    super.key,
    this.text = "Continue with Apple",
    this.borderRadius = 12,
    this.backgroundColor,
    this.textColor,
    this.showText = true,
    this.size = 56,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Only show on Apple platforms
    // if (!Platform.isIOS && !Platform.isMacOS) {
    //   return const SizedBox.shrink();
    // }

    final buttonContent = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "lib/assets/apple.svg",
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
        backgroundColor:  Colors.white,
        padding:const EdgeInsets.symmetric(vertical: 14),
        elevation: 0,
        shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
      ),
      child:buttonContent,
    );
  }
}
