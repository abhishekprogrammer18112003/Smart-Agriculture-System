// import 'package:flutter/material.dart';

// class AuthForm extends StatefulWidget {
//   final Function(String email, String password, bool isLogin) onAuthenticate;

//   AuthForm(this.onAuthenticate);

//   @override
//   _AuthFormState createState() => _AuthFormState();
// }

// class _AuthFormState extends State<AuthForm> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool isLogin = true;

//   void _submit() {
//     final email = _emailController.text.trim();
//     final password = _passwordController.text.trim();

//     if (email.isEmpty || password.isEmpty) return;

//     widget.onAuthenticate(email, password, isLogin);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           TextField(
//             controller: _emailController,
//             decoration: InputDecoration(labelText: 'Email'),
//           ),
//           TextField(
//             controller: _passwordController,
//             decoration: InputDecoration(labelText: 'Password'),
//             obscureText: true,
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: _submit,
//             child: Text(isLogin ? 'Login' : 'Signup'),
//           ),
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 isLogin = !isLogin;
//               });
//             },
//             child: Text(isLogin ? 'Create an account' : 'Already have an account? Login'),
//           ),
//         ],
//       ),
//     );
//   }
// }
