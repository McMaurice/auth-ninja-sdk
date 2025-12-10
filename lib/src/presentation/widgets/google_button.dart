import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class GoogleLoginButton extends ConsumerWidget {
  final String text;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? textColor;
  final bool showText;
  final bool isCircular;
  final double size; // used for circular mode
  final VoidCallback? onPressed;

  const GoogleLoginButton({
    super.key,
    this.text = "Continue with Google",
    this.borderRadius = 12,
    this.backgroundColor,
    this.textColor,
    this.showText = true,
    this.isCircular = false,
    this.size = 56, // default circular size
    this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonContent = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "lib/assets/Google.svg",
          package: 'auth_ninja_sdk',
          width: 22,
          height: 22,
        ),
        if (showText) ...[
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: textColor ?? Colors.black87,
              fontSize: 16,
            ),
          ),
        ]
      ],
    );

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.white,
        padding: isCircular
            ? EdgeInsets.zero
            : const EdgeInsets.symmetric(vertical: 14),
        fixedSize: isCircular ? Size(size, size) : null,
        elevation: 0,
        shape: isCircular
            ? const CircleBorder()
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
        side: const BorderSide(color: Color.fromARGB(255, 226, 225, 225), width: 1),
      ),
      child: isCircular
          ? SvgPicture.asset(
              "lib/assets/Google.svg",
              package: 'auth_ninja_sdk',
              width: size * 0.45,
              height: size * 0.45,
            )
          : buttonContent,
    );
  }
}