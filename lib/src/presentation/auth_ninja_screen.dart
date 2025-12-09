import 'package:auth_ninja_sdk/src/presentation/widgets/email_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/social_login_section.dart';
import '../core/auth_ninja_config.dart';

enum AuthMode { login, signup }

class AuthNinjaScreen extends ConsumerStatefulWidget {
  final AuthConfig config;
  final AuthMode initialMode;
  final double logoheight;

  const AuthNinjaScreen({
    super.key,
    this.logoheight = 100,
    required this.config,
    this.initialMode = AuthMode.login,
  });

  @override
  ConsumerState<AuthNinjaScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthNinjaScreen> {
  late AuthMode mode;

  @override
  void initState() {
    super.initState();
    mode = widget.initialMode;
  }

  void toggleMode() {
    setState(() => mode = mode == AuthMode.login ? AuthMode.signup : AuthMode.login);
  }

  Future<void> handleEmailSubmit(
    String email,
    String password,
    Map<String, String>? customFields,
  ) async {
    // final authNotifier = ref.read(authNotifierProvider.notifier);
    try {
      if (mode == AuthMode.login) {
        // await authNotifier.signInWithEmail(email, password);
      } else {
        // await authNotifier.signUpWithEmail(email, password, customFields);
        debugPrint('Email: $email');
        debugPrint('Custom Fields: $customFields');
      }
    } catch (e) {
      // Error handling: You can show a Snackbar or use your AuthState errorMessage
      // final errorMsg = ref.read(authNotifierProvider).errorMessage ?? "An error occurred";
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMsg)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = mode == AuthMode.login ? widget.config.loginTitle : widget.config.signUpTitle;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.config.logoAssetPath != null)
                Image.asset(widget.config.logoAssetPath!, height: widget.logoheight),
              const SizedBox(height: 24),
              Text(
                title,
                style: widget.config.titleTextStyle ?? Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              
              // Email login/signup form
              EmailLoginForm(
                mode: mode == AuthMode.login ? FormMode.login : FormMode.signup,
                customFields: widget.config.signupCustomFields,
                emailHint: widget.config.emailHint,
                passwordHint: widget.config.passwordHint,
                buttonText: mode == AuthMode.login
                    ? widget.config.loginButtonText
                    : widget.config.signUpButtonText,
                padding: const EdgeInsets.symmetric(horizontal: 0),
                buttonColor: Colors.amberAccent,
                buttonBorderRadius: 40,
                fieldBorderRadius: 40,
                onSubmit: handleEmailSubmit,
              ),
          
              const SizedBox(height: 24),
              
              Spacer(),
              
              // Social login buttons
              SocialLoginSection(
                isRow: true,
                googleCircular: true,
                appleCircular: true,
                showGoogle: widget.config.enableGoogleAuth,
                showApple: widget.config.enableAppleAuth,
                googleBackground: Colors.white,
                applebackground: Colors.white,
              ),
          
              const SizedBox(height: 16),
              
          
              // Mode toggle link
              TextButton(
                onPressed: toggleMode,
                child: Text(
                  mode == AuthMode.login
                      ? "Don't have an account? Sign Up"
                      : "Already have an account? Sign In",
                  textAlign: TextAlign.center,
                  style: widget.config.buttonTextStyle ?? const TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}