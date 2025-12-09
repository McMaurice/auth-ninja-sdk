import 'package:flutter/material.dart';
import '../../core/utils/helper/validators.dart';
import '../../core/auth_ninja_config.dart';

enum FormMode { login, signup }

class EmailLoginForm extends StatefulWidget {
  final Future<void> Function(String email, String password, Map<String, String>? customFields) onSubmit;
  final FormMode mode;
  final List<CustomFormField>? customFields;

  // Hints & texts
  final String emailHint;
  final String passwordHint;
  final String buttonText;

  // Layout
  final EdgeInsets padding;
  final double spacing; 

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
    this.customFields,
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
    customFieldControllers = {};
    if (widget.customFields != null) {
      for (var field in widget.customFields!) {
        customFieldControllers[field.fieldName] = TextEditingController();
      }
    }
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
      Map<String, String>? customData;
      if (widget.customFields != null && widget.customFields!.isNotEmpty) {
        customData = {};
        for (var field in widget.customFields!) {
          customData[field.fieldName] = customFieldControllers[field.fieldName]?.text ?? '';
        }
      }
      await widget.onSubmit(emailCtrl.text.trim(), passCtrl.text, customData);
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
            TextFormField(
              controller: emailCtrl,
              validator: AppValidators.emailOrUsername,
              decoration: InputDecoration(
                labelText: widget.emailHint,
                filled: true,
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.fieldBorderRadius),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.fieldBorderRadius),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.fieldBorderRadius),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              style: widget.inputTextStyle,
            ),

            SizedBox(height: widget.spacing),

            // Password field
            TextFormField(
              controller: passCtrl,
              obscureText: obscurePassword,
              validator: AppValidators.password,
              decoration: InputDecoration(
                labelText: widget.passwordHint,
                filled: true,
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.fieldBorderRadius),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.fieldBorderRadius),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.fieldBorderRadius),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
                suffixIcon: widget.showPasswordToggle
                    ? GestureDetector(
                        onTap: () =>
                            setState(() => obscurePassword = !obscurePassword),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: obscurePassword
                              ? (widget.obscurePasswordToggleBuilder ??
                                  const Icon(Icons.visibility_off, size: 20))
                              : (widget.visiblePasswordToggleBuilder ??
                                  const Icon(Icons.visibility, size: 20)),
                        ),
                      )
                    : null,
              ),
              style: widget.inputTextStyle,
            ),

            // Custom signup fields
            if (widget.mode == FormMode.signup && widget.customFields != null)
              ...widget.customFields!.map((field) {
                return Column(
                  children: [
                    SizedBox(height: widget.spacing),
                    TextFormField(
                      controller: customFieldControllers[field.fieldName],
                      keyboardType: field.inputType,
                      validator: field.validator ??
                          (field.isRequired
                              ? (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return '${field.label} is required';
                                  }
                                  return null;
                                }
                              : null),
                      decoration: InputDecoration(
                        labelText: field.label,
                        hintText: field.hint,
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(widget.fieldBorderRadius),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(widget.fieldBorderRadius),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(widget.fieldBorderRadius),
                          borderSide: const BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                      style: widget.inputTextStyle,
                    ),
                  ],
                );
              }).toList(),

            SizedBox(height: widget.spacing * 1.5),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading ? null : _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(widget.buttonBorderRadius),
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
                        style: widget.buttonTextStyle ??
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