
# AuthNinja SDK

A flexible Flutter authentication SDK for Firebase projects. You use it with the built-in UI or your own UI. The SDK supports email and password, Google, Apple, and Facebook sign-in. It offers strong typing, token refresh, clear errors, and reactive state.

---

# Preview Image

Add your screenshot here.

Example:
`/assets/auth_ninja_preview.png`

---

# Features

• Plug and Play UI, customizable screens
• Headless mode
• Email and password, Google, Apple, Facebook
• Stream based state
• Clear error flow
• Token refresh
• Simple testing with a custom repository

---

# Installation

Add this to pubspec.yaml.

dependencies:
auth_ninja_sdk: ^1.0.0
firebase_core: ^3.0.0
firebase_auth: ^5.0.0

auth_ninja_sdk:
path: ../auth_ninja_sdk
firebase_core: ^3.0.0
firebase_auth: ^5.0.0
Use GitHub
git:
url: https://github.com/McMaurice/auth-ninja-sdk

Run => flutter pub get

---

# Firebase Setup

Follow these steps before you use the SDK.

## Firebase Project

• Create a Firebase project
• Add Android, iOS, Web
• Download google-services.json for Android
• Download GoogleService-Info.plist for iOS
• Enable Email and Password, Google, Apple, Facebook

## Android Setup

• Add SHA1 and SHA256 in Firebase settings
• Add Google reversed client id in android manifest
• Add Facebook app id if you use Facebook
• Add google-services plugin in Gradle files

## iOS Setup

• Add GoogleService-Info.plist
• Add URL schemes for Google
• Add Sign in with Apple capability
• Add Facebook settings if you use Facebook

## Web Setup

• Add Firebase config to web/index.html
• Add redirect domain in Firebase console
• Enable each provider

---

# Usage

You choose UI mode or headless mode.

## Initialize Firebase

void main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
);
runApp(MyApp());
}

---

# Mode A: Built-in UI

import 'package:auth_ninja_sdk/auth_ninja_sdk.dart';

class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
return MaterialApp(
home: AuthNinjaScreen(
initialMode: AuthMode.login,
config: AuthConfig(
loginTitle: 'Welcome Back!',
signUpTitle: 'Create Account',
enableGoogleAuth: true,
enableAppleAuth: true,
enableFacebookAuth: true,
primaryColor: Colors.blue,
),
onApplePressed: () => const HomeScreen(),
onGooglePressed: () => const HomeScreen(),
),
);
}
}

---

# Mode B: Headless

import 'package:auth_ninja_sdk/auth_ninja_sdk.dart';

final ninja = AuthNinja.instance;

final state = await ninja.signInWithEmail(
'[user@example.com](mailto:user@example.com)',
'password123',
);

if (state is Authenticated) {
print(state.user.email);
}

---

# Connecting Custom UI

Use the singleton in your UI logic.

Future<void> submitLogin(String email, String password) async {
final result = await AuthNinja.instance.signInWithEmail(email, password);

if (result is Authenticated) {
// move to home
}

if (result is AuthError) {
// show message
}
}

---

# Provider Setup

Each provider needs simple steps.

## Email and Password

• Enable in Firebase console

## Google

Android
• Add SHA keys
• Add reversed client id in manifest

iOS
• Add reversed client id in Info.plist

Web
• Add redirect domain

## Apple

iOS
• Add Apple capability
• Add bundle id in Apple developer panel

Web
• Add domain to Apple services

## Facebook

Android
• Add Facebook app id
• Add key hash in Facebook developer panel

iOS
• Add FacebookAppID in Info.plist

Web
• Add OAuth redirect domain

---

# API Summary

AuthNinja.instance
• signInWithEmail
• signUpWithEmail
• resetPassword
• signInWithGoogle
• signInWithApple
• signInWithFacebook
• signOut
• authStateChanges
• currentUser helpers
• token check and refresh
• ensureValidToken

Example
final info = AuthNinja.instance.getCurrentUserInfo();
print(info);

---

# Testing

Pass a mock repo when you want to override Firebase.

AuthNinja.initialize(repository: mockRepo);

Reset between tests.
AuthNinja.reset();

---

# License

MIT License, short form.

Copyright (c) 2025 AuthNinja

Permission is granted to use, copy, modify, and distribute this software.
This software is provided without warranty.
