// import 'package:agro_smart/features/onboarding/screens/auth_form.dart';
// import 'package:agro_smart/features/onboarding/screens/auth_service.dart';
// import 'package:flutter/material.dart';

// class AuthScreen extends StatefulWidget {
//   @override
//   _AuthScreenState createState() => _AuthScreenState();
// }

// class _AuthScreenState extends State<AuthScreen> {
//   void _authenticate(String email, String password, bool isLogin) async {
//     try {
//       if (isLogin) {
//         await AuthService.login(email, password);
//         // Login logic can be handled here
//       } else {
//         await AuthService.signUp(email, password);
//         showDialog(
//           context: context,
//           builder: (ctx) => AlertDialog(
//             title: Text('Verify Email'),
//             content: Text('Check your email for the verification link.'),
//             actions: [
//               TextButton(
//                 child: Text('OK'),
//                 onPressed: () => Navigator.of(ctx).pop(),
//               ),
//             ],
//           ),
//         );
//       }
//     } catch (e) {
//       showDialog(
//         context: context,
//         builder: (ctx) => AlertDialog(
//           title: Text('Error'),
//           content: Text(e.toString()),
//           actions: [
//             TextButton(
//               child: Text('OK'),
//               onPressed: () => Navigator.of(ctx).pop(),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Auth')),
//       body: AuthForm(_authenticate),
//     );
//   }
// }
