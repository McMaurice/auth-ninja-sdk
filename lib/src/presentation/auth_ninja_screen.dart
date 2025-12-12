import 'package:auth_ninja_sdk/auth_ninja_sdk.dart';
import 'package:auth_ninja_sdk/src/presentation/widgets/auth_ninja_error_banner.dart';
import 'package:auth_ninja_sdk/src/presentation/widgets/email_password_form.dart';
import 'package:auth_ninja_sdk/src/presentation/widgets/or_divider.dart';
import 'package:auth_ninja_sdk/src/providers/auth_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/social_login_section.dart';

class AuthNinjaScreen extends ConsumerStatefulWidget {
  final AuthNinjaConfig config;
  final Future<void> Function(String email, String password)? onEmailPasswordSubmit;
  final Future<void> Function(String email, String password)? onEmailPasswordSignUpSubmit;
  final VoidCallback? onLoginSubmit;
  final VoidCallback? onSignupSubmit;
  final VoidCallback? onGooglePressed;
  final VoidCallback? onApplePressed;
  final VoidCallback? onSuccess;
  final VoidCallback? onEmailLoginSuccess;  
  final VoidCallback? onEmailSignUpSuccess;

  const AuthNinjaScreen({
    super.key,
    required this.config,
    this.onGooglePressed,
    this.onApplePressed,
    this.onEmailPasswordSubmit,
    this.onLoginSubmit,
    this.onSignupSubmit,
    this.onSuccess,
    this.onEmailLoginSuccess,
    this.onEmailSignUpSuccess,
    this.onEmailPasswordSignUpSubmit,
  });

  @override
  ConsumerState<AuthNinjaScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthNinjaScreen> {
  bool _isLoginMode = true; // true = Login, false = Signup
  

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);
    
    if (authState.status == AuthNinjaStatus.authenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_isLoginMode && widget.onEmailLoginSuccess != null) {
          widget.onEmailLoginSuccess!.call();
        } else if (!_isLoginMode && widget.onEmailSignUpSuccess != null) {
          widget.onEmailSignUpSuccess!.call();
        }
      });
    }
    // Simple error handling: just show it once
    if (authState.errorMessage != null && authState.errorMessage!.isNotEmpty) {
      // Future.microtask to ensure this runs after build
      Future.microtask(() {
        AuthNinjaErrorBanner.show(
          context: context,
          errorMessage: authState.errorMessage!,
        );
      });
    }
    final title = _isLoginMode
        ? widget.config.loginTitle
        : widget.config.signUpTitle;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo
                if (widget.config.logoAssetPath != null)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        widget.config.logoAssetPath!,
                        height: widget.config.logoheight,
                      ),
                    ),
                  ),

                const SizedBox(height: 40),

                // Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    title,
                    style:
                        widget.config.titleTextStyle ??
                        Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.start,
                  ),
                ),

                const SizedBox(height: 32),

                // Email/Password Form
                EmailPasswordForm(
                  isLoginMode: _isLoginMode,
                  onSubmit: (email, password) async {
                    try {
                      if (_isLoginMode) {
                        if (widget.onEmailPasswordSubmit != null) {
                          await widget.onEmailPasswordSubmit!(email, password);
                        } else {
                          await authNotifier.signInWithEmail(email, password);
                        }
                      } else {
                        if (widget.onEmailPasswordSignUpSubmit != null) {
                          await widget.onEmailPasswordSignUpSubmit!(
                            email,
                            password,
                          );
                        } else {
                          await authNotifier.signUpWithEmail(email, password);
                        }
                      }
                    } catch (e) {
                      // Only show error if using notifier fallback
                      if (widget.onEmailPasswordSubmit == null &&
                          widget.onEmailPasswordSignUpSubmit == null &&
                          e is AuthNinjaException) {
                        AuthNinjaErrorBanner.show(
                          context: context,
                          errorMessage: e.message,
                        );
                      }
                    }
                  },
                  emailHint: widget.config.emailHint,
                  passwordHint: widget.config.passwordHint,
                  buttonText: _isLoginMode
                      ? widget.config.loginButtonText
                      : widget.config.signUpButtonText,
                  buttonColor: widget.config.primaryColor ?? Colors.amberAccent,
                  buttonBorderRadius: 40,
                  fieldBorderRadius: 40,
                  isLoading: false, // or use authState.isLoading if you want
                ),

                const SizedBox(height: 24),

                // Show social logins only if enabled
                if (widget.config.enableGoogleAuth ||
                    widget.config.enableAppleAuth) ...[
                  const OrDivider(),
                  const SizedBox(height: 16),

                  SocialLoginSection(
                    onApplePressed: widget.config.enableAppleAuth
                        ? widget.onApplePressed
                        : null,
                    onGooglePressed: widget.config.enableGoogleAuth
                        ? widget.onGooglePressed
                        : null,
                    isLoading: false, // remove notifier dependency
                  ),
                ],
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isLoginMode
                          ? "Don't have an account?"
                          : "Already have an account?",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        setState(() => _isLoginMode = !_isLoginMode);
                        authNotifier.clearError();
                      },
                      child: Text(
                        _isLoginMode ? "Sign Up" : "Sign In",
                        style: TextStyle(
                          color:
                              widget.config.primaryColor ??
                              Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
