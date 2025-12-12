import 'package:auth_manager/presentation/screens/login_screen.dart';
import 'package:auth_ninja_sdk/auth_ninja_sdk.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _navigateToLogIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (ctx) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ninja = AuthNinja.instance;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Home Screen!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(ninja.currentUserEmail!),
             const SizedBox(height: 5),
            Text("LogIn Provider: ${ninja.currentProviderId!}"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await ninja.signOut();
                if (!ninja.isSignedIn && mounted) {
                  _navigateToLogIn();
                }
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
