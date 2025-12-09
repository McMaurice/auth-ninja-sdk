// import 'package:auth_ninja_sdk/src/core/auth_ninja_config.dart';
// import 'package:auth_ninja_sdk/src/presentation/auth_gate_screen.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Auth SDK Test',
//       home: NinjaGateScreen(
//         config: AuthNinjaConfig(
//           appName: 'NinjaAuth',
//         ),
//         onEmailLogin: (email, password) {},
//         onEmailSignUp: (email, password) {},
//         onGoogleAuth: () {},
//         onAppleAuth: () {},
//       ),
//     );
//   }
// }





// import 'package:flutter/material.dart';

// class AuthNinjaConfig {
//   final bool enableEmailAuth;
//   final bool enableGoogleAuth;
//   final bool enableAppleAuth;
//   final String? appName;
//   final String? logoAssetPath;
//   final Color? primaryColor;
//   final Color? accentColor;
//   final String loginTitle;
//   final String signUpTitle;
//   final String emailHint;
//   final String passwordHint;
//   final String loginButtonText;
//   final String signUpButtonText;

//   const AuthNinjaConfig({
//     this.enableEmailAuth = true,
//     this.enableGoogleAuth = true,
//     this.enableAppleAuth = true,
//     this.appName,
//     this.logoAssetPath,
//     this.primaryColor,
//     this.accentColor,
//     this.loginTitle = 'Welcome Back',
//     this.signUpTitle = 'Create Account',
//     this.emailHint = 'Email',
//     this.passwordHint = 'Password',
//     this.loginButtonText = 'Sign In',
//     this.signUpButtonText = 'Sign Up',
//   });
// }












// import 'package:auth_ninja_sdk/src/core/auth_ninja_config.dart';
// import 'package:flutter/material.dart';

// class NinjaGateScreen extends StatefulWidget {
//   final AuthNinjaConfig config;
//   final Function(String email, String password)? onEmailLogin;
//   final Function(String email, String password)? onEmailSignUp;
//   final VoidCallback? onGoogleAuth;
//   final VoidCallback? onAppleAuth;

//   const NinjaGateScreen({
//     super.key,
//     required this.config,
//     this.onEmailLogin,
//     this.onEmailSignUp,
//     this.onGoogleAuth,
//     this.onAppleAuth,
//   });

//   @override
//   State<NinjaGateScreen> createState() => _NinjaGateScreenState();
// }

// class _NinjaGateScreenState extends State<NinjaGateScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _obscurePassword = true;
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   Color get _primaryColor =>
//       widget.config.primaryColor ?? const Color(0xFF6C63FF);
//   Color get _accentColor =>
//       widget.config.accentColor ?? const Color(0xFF4CAF50);

//   Future<void> _handleEmailAuth() async {
//     if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fill in all fields')),
//       );
//       return;
//     }

//     setState(() => _isLoading = true);

//     await Future.delayed(const Duration(seconds: 1));

//     if (_tabController.index == 0) {
//       widget.onEmailLogin
//           ?.call(_emailController.text, _passwordController.text);
//     } else {
//       widget.onEmailSignUp
//           ?.call(_emailController.text, _passwordController.text);
//     }

//     setState(() => _isLoading = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               _primaryColor.withOpacity(0.1),
//               _accentColor.withOpacity(0.05),
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: Center(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(24.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   _buildHeader(),
//                   const SizedBox(height: 40),
//                   _buildAuthCard(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Column(
//       children: [
//         if (widget.config.logoAssetPath != null)
//           Container(
//             width: 80,
//             height: 80,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: _primaryColor.withOpacity(0.3),
//                   blurRadius: 20,
//                   offset: const Offset(0, 10),
//                 ),
//               ],
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(20),
//               child: Image.asset(
//                 widget.config.logoAssetPath!,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           )
//         else
//           Container(
//             width: 80,
//             height: 80,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [_primaryColor, _accentColor],
//               ),
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: _primaryColor.withOpacity(0.3),
//                   blurRadius: 20,
//                   offset: const Offset(0, 10),
//                 ),
//               ],
//             ),
//             child:
//                 const Icon(Icons.rocket_launch, color: Colors.white, size: 40),
//           ),
//         const SizedBox(height: 16),
//         Text(
//           widget.config.appName ?? 'Nexus',
//           style: TextStyle(
//             fontSize: 32,
//             fontWeight: FontWeight.bold,
//             color: _primaryColor,
//             letterSpacing: 1.2,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildAuthCard() {
//     return Container(
//       constraints: const BoxConstraints(maxWidth: 450),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 30,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           _buildTabBar(),
//           Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Column(
//               children: [
//                 if (widget.config.enableEmailAuth) ...[
//                   _buildEmailAuthForm(),
//                   const SizedBox(height: 24),
//                 ],
//                 if ((widget.config.enableGoogleAuth ||
//                         widget.config.enableAppleAuth) &&
//                     widget.config.enableEmailAuth)
//                   _buildDivider(),
//                 if (widget.config.enableGoogleAuth ||
//                     widget.config.enableAppleAuth) ...[
//                   const SizedBox(height: 24),
//                   _buildSocialAuth(),
//                 ],
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTabBar() {
//     return Container(
//       margin: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: TabBar(
//         controller: _tabController,
//         indicator: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [_primaryColor, _accentColor],
//           ),
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: _primaryColor.withOpacity(0.3),
//               blurRadius: 8,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         labelColor: Colors.white,
//         unselectedLabelColor: Colors.grey[600],
//         indicatorSize: TabBarIndicatorSize.tab,
//         dividerColor: Colors.transparent,
//         tabs: [
//           Tab(
//             child: Text(
//               widget.config.loginTitle,
//               style: const TextStyle(fontWeight: FontWeight.w600),
//             ),
//           ),
//           Tab(
//             child: Text(
//               widget.config.signUpTitle,
//               style: const TextStyle(fontWeight: FontWeight.w600),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmailAuthForm() {
//     return Column(
//       children: [
//         _buildTextField(
//           controller: _emailController,
//           hint: widget.config.emailHint,
//           icon: Icons.email_outlined,
//           keyboardType: TextInputType.emailAddress,
//         ),
//         const SizedBox(height: 16),
//         _buildTextField(
//           controller: _passwordController,
//           hint: widget.config.passwordHint,
//           icon: Icons.lock_outline,
//           obscureText: _obscurePassword,
//           suffixIcon: IconButton(
//             icon: Icon(
//               _obscurePassword
//                   ? Icons.visibility_outlined
//                   : Icons.visibility_off_outlined,
//               color: Colors.grey[600],
//             ),
//             onPressed: () =>
//                 setState(() => _obscurePassword = !_obscurePassword),
//           ),
//         ),
//         const SizedBox(height: 24),
//         _buildPrimaryButton(),
//       ],
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String hint,
//     required IconData icon,
//     bool obscureText = false,
//     Widget? suffixIcon,
//     TextInputType? keyboardType,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.grey[50],
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[200]!),
//       ),
//       child: TextField(
//         controller: controller,
//         obscureText: obscureText,
//         keyboardType: keyboardType,
//         decoration: InputDecoration(
//           hintText: hint,
//           prefixIcon: Icon(icon, color: _primaryColor),
//           suffixIcon: suffixIcon,
//           border: InputBorder.none,
//           contentPadding:
//               const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//         ),
//       ),
//     );
//   }

//   Widget _buildPrimaryButton() {
//     return SizedBox(
//       width: double.infinity,
//       height: 56,
//       child: ElevatedButton(
//         onPressed: _isLoading ? null : _handleEmailAuth,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: _primaryColor,
//           foregroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           elevation: 0,
//         ),
//         child: _isLoading
//             ? const SizedBox(
//                 width: 24,
//                 height: 24,
//                 child: CircularProgressIndicator(
//                   color: Colors.white,
//                   strokeWidth: 2,
//                 ),
//               )
//             : Text(
//                 _tabController.index == 0
//                     ? widget.config.loginButtonText
//                     : widget.config.signUpButtonText,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//       ),
//     );
//   }

//   Widget _buildDivider() {
//     return Row(
//       children: [
//         Expanded(child: Divider(color: Colors.grey[300])),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Text(
//             'or continue with',
//             style: TextStyle(color: Colors.grey[600], fontSize: 14),
//           ),
//         ),
//         Expanded(child: Divider(color: Colors.grey[300])),
//       ],
//     );
//   }

//   Widget _buildSocialAuth() {
//     return Row(
//       children: [
//         if (widget.config.enableGoogleAuth)
//           Expanded(
//             child: _buildSocialButton(
//               icon: Icons.g_mobiledata,
//               label: 'Google',
//               onPressed: widget.onGoogleAuth,
//             ),
//           ),
//         if (widget.config.enableGoogleAuth && widget.config.enableAppleAuth)
//           const SizedBox(width: 12),
//         if (widget.config.enableAppleAuth)
//           Expanded(
//             child: _buildSocialButton(
//               icon: Icons.apple,
//               label: 'Apple',
//               onPressed: widget.onAppleAuth,
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildSocialButton({
//     required IconData icon,
//     required String label,
//     VoidCallback? onPressed,
//   }) {
//     return OutlinedButton(
//       onPressed: onPressed,
//       style: OutlinedButton.styleFrom(
//         padding: const EdgeInsets.symmetric(vertical: 16),
//         side: BorderSide(color: Colors.grey[300]!),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, color: Colors.grey[800], size: 24),
//           const SizedBox(width: 8),
//           Text(
//             label,
//             style: TextStyle(
//               color: Colors.grey[800],
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
