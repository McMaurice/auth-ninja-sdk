import 'dart:io';
import 'package:auth_ninja_sdk/auth_ninja_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppleLoginButton extends ConsumerWidget {
  final String text;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? textColor;
  final bool showText;
  final bool isCircular;
  final double size;
  final VoidCallback? onPressed;

  AppleLoginButton({
    super.key,
    this.text = "Continue with Apple",
    this.borderRadius = 12,
    this.backgroundColor,
    this.textColor,
    this.showText = true,
    this.isCircular = false,
    this.size = 56,
    this.onPressed,
  });

  final ninja = AuthNinja.instance;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Only show on Apple platforms
    if (!Platform.isIOS && !Platform.isMacOS) {
      return const SizedBox.shrink();
    }

    final buttonContent = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "lib/assets/apple.svg",
          package: 'auth_ninja_sdk',
          width: 22,
          height: 22,
        ),
        if (showText) ...[
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(color: textColor ?? Colors.white, fontSize: 16),
          ),
        ],
      ],
    );

    return ElevatedButton(
      onPressed: ninja.signInWithApple,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.black,
        padding: isCircular
            ? EdgeInsets.zero
            : const EdgeInsets.symmetric(vertical: 14),
        fixedSize: isCircular ? Size(size, size) : null,
        shape: isCircular
            ? const CircleBorder()
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
      ),
      child: isCircular
          ? SvgPicture.asset(
              "lib/assets/apple.svg",
              package: 'auth_ninja_sdk',
              width: size * 0.45,
              height: size * 0.45,
            )
          : buttonContent,
    );
  }
}
