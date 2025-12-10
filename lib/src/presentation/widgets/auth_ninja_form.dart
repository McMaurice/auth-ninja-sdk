import 'package:auth_ninja_sdk/src/core/utils/helper/validators.dart';
import 'package:flutter/material.dart';
import 'ninja_input_field.dart';

class AuthForm extends StatefulWidget {
  final bool isSignUpMode;
  final VoidCallback onToggleMode;
  final Future<void> Function(String email, String password) onSubmit;
  final String submitButtonText;
  final Color? buttonColor;
  
  const AuthForm({
    super.key,
    required this.isSignUpMode,
    required this.onToggleMode,
    required this.onSubmit,
    required this.submitButtonText,
    this.buttonColor,
  });
  
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  bool _obscurePassword = true;
  bool _isLoading = false;
  String? errorFeedback;
  
  @override
  void initState() {
    super.initState();
    // Listen to mode changes if widget.isSignUpMode can change externally
  }
  
  @override
  void didUpdateWidget(covariant AuthForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Clear form when mode changes
    if (oldWidget.isSignUpMode != widget.isSignUpMode) {
      _clearForm();
    }
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  void _clearForm() {
    _formKey.currentState?.reset();
    _emailController.clear();
    _passwordController.clear();
    setState(() {
      errorFeedback = null;
      _obscurePassword = true;
    });
  }
  
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() {
      _isLoading = true;
      errorFeedback = null;
    });
    
    try {
      await widget.onSubmit(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    } catch (e) {
      setState(() {
        errorFeedback = widget.isSignUpMode
            ? 'Could not sign up with those details'
            : 'Incorrect login credentials';
      });
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
  
  void _handleToggleMode() {
    // Clear the form before toggling
    _clearForm();
    // Then call the parent's toggle callback
    widget.onToggleMode();
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // EMAIL FIELD
            NinjaInputField(
              controller: _emailController,
              label: 'Email',
              hint: 'you@example.com',
              keyboardType: TextInputType.emailAddress,
              validator: AppValidators.email,
              borderRadius: 8,
              textStyle: Theme.of(context).textTheme.bodyMedium,
            ),
            
            const SizedBox(height: 16),
            
            // PASSWORD FIELD
            NinjaInputField(
              controller: _passwordController,
              label: 'Password',
              hint: widget.isSignUpMode ? 'Create a password' : 'Enter your password',
              obscureText: _obscurePassword,
              validator: (value) => AppValidators.password(value, isSignUpMode: widget.isSignUpMode),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey[600],
                ),
                onPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
              ),
              borderRadius: 8,
              textStyle: Theme.of(context).textTheme.bodyMedium,
            ),
            
            const SizedBox(height: 16),
            

            const SizedBox(height: 16),
            
            // SUBMIT BUTTON
            ElevatedButton(
              onPressed: _isLoading ? null : _submit,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: widget.buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
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
                      widget.submitButtonText,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
            
            const SizedBox(height: 24),
            
            // TOGGLE MODE BUTTON
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.isSignUpMode
                      ? 'Already have an account?'
                      : 'Don\'t have an account yet?',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _handleToggleMode,
                  child: Text(
                    widget.isSignUpMode ? 'Sign In' : 'Register',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  
}