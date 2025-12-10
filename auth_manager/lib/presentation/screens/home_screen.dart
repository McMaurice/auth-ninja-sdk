import 'package:auth_manager/presentation/screens/login_screen.dart';
import 'package:auth_ninja_sdk/auth_ninja_sdk.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ninja = AuthNinja.instance;
    final userInfo = ninja.getCurrentUserInfo();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Home Screen!',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              userInfo?['email'] ?? 'No email',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async{
                await ninja.signOut();
                if (!ninja.isSignedIn) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
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
