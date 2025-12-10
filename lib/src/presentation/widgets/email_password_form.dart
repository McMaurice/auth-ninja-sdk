import 'package:auth_ninja_sdk/src/presentation/widgets/ninja_input_field.dart';
import 'package:flutter/material.dart';
import '../../core/utils/helper/validators.dart';

enum FormMode { login, signup }

class EmailLoginForm extends StatefulWidget {
  final Future<void> Function(String email, String password) onSubmit;
  final FormMode mode;

  // Hints & texts
  final String emailHint;
  final String passwordHint;
  final String buttonText;

  // Layout
  final EdgeInsets padding;
  final double spacing; // vertical spacing between elements

  // Field styles
  final double fieldBorderRadius;
  final Color? fieldBorderColor;
  final TextStyle? inputTextStyle;

  // Button styles
  final double buttonBorderRadius;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final TextStyle? buttonTextStyle;

  // Loading indicator
  final Color? loadingIndicatorColor;

  // Password toggle
  final bool showPasswordToggle;
  final Widget? obscurePasswordToggleBuilder;
  final Widget? visiblePasswordToggleBuilder;

  const EmailLoginForm({
    super.key,
    required this.onSubmit,
    this.mode = FormMode.login,
    this.emailHint = "Email",
    this.passwordHint = "Password",
    this.buttonText = "Sign In",
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
    this.spacing = 16,
    this.fieldBorderRadius = 8,
    this.fieldBorderColor,
    this.inputTextStyle,
    this.buttonBorderRadius = 12,
    this.buttonColor,
    this.buttonTextColor,
    this.buttonTextStyle,
    this.loadingIndicatorColor,
    this.showPasswordToggle = true,
    this.obscurePasswordToggleBuilder,
    this.visiblePasswordToggleBuilder,
  });

  @override
  State<EmailLoginForm> createState() => _EmailLoginFormState();
}

class _EmailLoginFormState extends State<EmailLoginForm> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late Map<String, TextEditingController> customFieldControllers;
  bool loading = false;
  bool obscurePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    for (var controller in customFieldControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => loading = true);
    try {
      await widget.onSubmit(emailCtrl.text.trim(), passCtrl.text.trim());
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: widget.padding,
        child: Column(
          children: [
            // Email field
            NinjaInputField(
              controller: emailCtrl,
              label: widget.emailHint,
              validator: AppValidators.email,
              keyboardType: TextInputType.emailAddress,
              borderRadius: widget.fieldBorderRadius,
              textStyle: widget.inputTextStyle,
            ),

            SizedBox(height: widget.spacing),

            // Password field
            NinjaInputField(
              controller: passCtrl,
              label: widget.passwordHint,
              validator: AppValidators.password,
              obscureText: obscurePassword,
              borderRadius: widget.fieldBorderRadius,
              textStyle: widget.inputTextStyle,
              suffixIcon: widget.showPasswordToggle
                  ? GestureDetector(
                      onTap: () =>
                          setState(() => obscurePassword = !obscurePassword),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: obscurePassword
                            ? (widget.obscurePasswordToggleBuilder ??
                                  const Icon(Icons.visibility_off))
                            : (widget.visiblePasswordToggleBuilder ??
                                  const Icon(Icons.visibility)),
                      ),
                    )
                  : null,
            ),
            SizedBox(height: widget.spacing * 1.5),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading ? null : _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.buttonColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      widget.buttonBorderRadius,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: loading
                    ? SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: widget.loadingIndicatorColor ?? Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    : Text(
                        widget.buttonText,
                        style:
                            widget.buttonTextStyle ??
                            TextStyle(
                              color: widget.buttonTextColor ?? Colors.white,
                              fontSize: 16,
                            ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
