// email_password_form.dart
import 'package:auth_ninja_sdk/src/core/utils/helper/validators.dart';
import 'package:flutter/material.dart';
import 'ninja_input_field.dart';

class EmailPasswordForm extends StatefulWidget {
  final bool isLoginMode;
  final Future<void> Function(String email, String password) onSubmit;
  final String buttonText;
  final Color? buttonColor;
  final double buttonBorderRadius;
  final double fieldBorderRadius;
  final String? emailHint;
  final String? passwordHint;
  
  const EmailPasswordForm({
    super.key,
    required this.isLoginMode,
    required this.onSubmit,
    required this.buttonText,
    this.buttonColor,
    this.buttonBorderRadius = 40,
    this.fieldBorderRadius = 40,
    this.emailHint,
    this.passwordHint,
  });
  
  @override
  State<EmailPasswordForm> createState() => _EmailPasswordFormState();
}

class _EmailPasswordFormState extends State<EmailPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _errorMessage;
  
  @override
  void didUpdateWidget(covariant EmailPasswordForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Clear form when mode changes
    if (oldWidget.isLoginMode != widget.isLoginMode) {
      _clearForm();
    }
  }
  
  void _clearForm() {
    _formKey.currentState?.reset();
    _emailController.clear();
    _passwordController.clear();
    setState(() {
      _errorMessage = null;
      _obscurePassword = true;
    });
  }
  
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    
    try {
      await widget.onSubmit(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    } catch (e) {
      setState(() {
        _errorMessage = widget.isLoginMode
            ? 'Incorrect email or password'
            : 'Could not create account. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Email Field
          NinjaInputField(
            controller: _emailController,
            label: 'Email',
            hint: widget.isLoginMode ? widget.emailHint ?? 'Create a password' : 'Enter your password',
            keyboardType: TextInputType.emailAddress,
            validator: AppValidators.email,
            borderRadius: widget.fieldBorderRadius,
            fillColor: Colors.white,
          ),
          
          const SizedBox(height: 16),
          
          // Password Field
          NinjaInputField(
            controller: _passwordController,
            label: 'Password',
            hint: widget.passwordHint ?? 
                (widget.isLoginMode ? 'Enter your password' : 'Create a password'),
            obscureText: _obscurePassword,
            validator: (value) => AppValidators.password(
              value, 
              isSignUpMode: !widget.isLoginMode,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey[600],
              ),
              onPressed: () {
                setState(() => _obscurePassword = !_obscurePassword);
              },
            ),
            borderRadius: widget.fieldBorderRadius,
            fillColor: Colors.white,
          ),
          
          const SizedBox(height: 8),
          
          
          // Forgot password link (login only)
          if (widget.isLoginMode)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // TODO: Implement forgot password flow
                },
                child: const Text('Forgot Password?'),
              ),
            ),
          
          const SizedBox(height: 10),
          
          // Submit Button
          ElevatedButton(
            onPressed: _isLoading ? null : _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.buttonColor,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.buttonBorderRadius),
              ),
            ),
            child: _isLoading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  )
                : Text(
                    widget.buttonText,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
  
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}