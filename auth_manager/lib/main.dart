import 'package:flutter/material.dart';
import 'package:auth_ninja_sdk/auth_ninja_sdk.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auth Manger App',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const SplashScreenWithAuthCheck(),
    );
  }
}

class SplashScreenWithAuthCheck extends StatefulWidget {
  const SplashScreenWithAuthCheck({super.key});

  @override
  State<SplashScreenWithAuthCheck> createState() =>
      _SplashScreenWithAuthCheckState();
}

class _SplashScreenWithAuthCheckState extends State<SplashScreenWithAuthCheck> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    // Show splash for minimum 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Check if user is already signed in
    final authNinja = AuthNinja.instance;

    if (authNinja.isSignedIn) {
      // User is already logged in, go to home
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(builder: (context) => const HomeScreen()),
      // );
    } else {
      // User not logged in, show auth screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const AuthNinjaScreen(
            config: AuthNinjaConfig(
              enableFacebookAuth: true,
              enableEmailAuth: true,
              loginButtonText: 'Login'
              // More customizations
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shield_outlined, size: 100, color: Colors.white),
            SizedBox(height: 24),
            Text(
              'Auth Ninja',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 50),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
