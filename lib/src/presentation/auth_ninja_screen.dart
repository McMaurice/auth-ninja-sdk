import 'package:auth_ninja_sdk/auth_ninja_sdk.dart';
import 'package:auth_ninja_sdk/src/presentation/widgets/email_password_form.dart';
import 'package:auth_ninja_sdk/src/presentation/widgets/or_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/social_login_section.dart';

enum AuthMode { login, signup }

class AuthNinjaScreen extends ConsumerStatefulWidget {
  final AuthNinjaConfig config;
  final AuthMode initialMode;
  final Function(String email, String password)? onEmaiPassword;
  final VoidCallback? onGooglePressed;
  final VoidCallback? onApplePressed;

  const AuthNinjaScreen({
    super.key,
    required this.config,
    this.initialMode = AuthMode.login,
    this.onGooglePressed,
    this.onApplePressed,
    this.onEmaiPassword,
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
    setState(
      () => mode = mode == AuthMode.login ? AuthMode.signup : AuthMode.login,
    );
  }

  Future<void> handleEmailSubmit(String email, String password) async {
    final ninja = AuthNinja.instance;
    try {
      if (mode == AuthMode.login) {
        await ninja.signInWithEmail(email, password);
        widget.onEmaiPassword;
      } else {
        await ninja.signUpWithEmail(email, password);
         widget.onEmaiPassword;
      }
    } catch (e) {
      // Error handling: You can show a Snackbar or use your AuthState errorMessage
      // final errorMsg = ref.read(authNotifierProvider).errorMessage ?? "An error occurred";
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMsg)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = mode == AuthMode.login
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
              mainAxisAlignment: .center,
              children: [
                if (widget.config.logoAssetPath != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      widget.config.logoAssetPath!,
                      height: widget.config.logoheight,
                      width: widget.config.logowidth,
                    ),
                  ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    title,
                    style:
                        // widget.config.titleTextStyle ??
                        Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(height: 32),

                // Email login/signup form
                EmailLoginForm(
                  mode: mode == AuthMode.login
                      ? FormMode.login
                      : FormMode.signup,
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

                const SizedBox(height: 60),
                const OrDivider(),
                const SizedBox(height: 16),

                // Social login buttons
                SocialLoginSection(
                  onApplePressed: widget.onApplePressed,
                  // () async => await ninja.signInWithApple(),
                  onGooglePressed: widget.onGooglePressed,
                  // () async {
                  //   await ninja.signInWithGoogle();
                  //   if (ninja.isSignedIn) {
                  //     Navigator.of(context).pop();
                  //   }
                  // },
                  showGoogle: widget.config.enableGoogleAuth,
                  showApple: widget.config.enableAppleAuth,
                ),

                const SizedBox(height: 16),

                // Mode toggle link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      mode == AuthMode.login
                          ? "Don't have an account? "
                          : "Already have an account? ",
                    ),
                    GestureDetector(
                      onTap: toggleMode,
                      child: Text(
                        mode == AuthMode.login ? "Sign Up" : "Sign In",
                        style: const TextStyle(
                          color: Colors.blue,
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

// import 'package:flutter/material.dart';

// import '../core/auth_ninja_config.dart';
// import '../domain/auth_ninja.dart';

// class AuthNinjaScreen extends StatefulWidget {
//   final AuthNinjaConfig config;

//   const AuthNinjaScreen({super.key, required this.config});

//   @override
//   State<AuthNinjaScreen> createState() => _AuthNinjaScreenState();
// }

// class _AuthNinjaScreenState extends State<AuthNinjaScreen> {
//   final _email = TextEditingController();
//   final _password = TextEditingController();
//   final ninja = AuthNinja.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             children: [
//               if (widget.config.logoAssetPath != null)
//                 Image.asset(widget.config.logoAssetPath!, height: 80),

//               if (widget.config.appName != null)
//                 Text(widget.config.appName!, style: const TextStyle(fontSize: 22)),

//               if (widget.config.enableEmailAuth)
//                 Column(
//                   children: [
//                     TextField(controller: _email),
//                     TextField(controller: _password, obscureText: true),
//                     ElevatedButton(
//                       onPressed: () async {
//                         await ninja.signInWithEmail(
//                           _email.text,
//                           _password.text,
//                         );
//                       },
//                       child: const Text('Sign In'),
//                     ),
//                   ],
//                 ),

//               if (widget.config.enableGoogleAuth)
//                 ElevatedButton(
//                   onPressed: () async => await ninja.signInWithGoogle(),
//                   child: const Text('Continue with Google'),
//                 ),

//               if (widget.config.enableAppleAuth)
//                 ElevatedButton(
//                   onPressed: () async => await ninja.signInWithApple(),
//                   child: const Text('Continue with Apple'),
//                 ),

//               if (widget.config.enableFacebookAuth)
//                 ElevatedButton(
//                   onPressed: () async => await ninja.signInWithFacebook(),
//                   child: const Text('Continue with Facebook'),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
