// // import 'package:agro_smart/core/constants/app_icons.dart';
// // import 'package:agro_smart/core/utils/custom_spacers.dart';
// // import 'package:agro_smart/core/utils/screen_utils.dart';
// // import 'package:agro_smart/features/onboarding/data/onboarding_provider.dart';
// // import 'package:agro_smart/features/onboarding/screens/login_with_otp_screen.dart';
// // import 'package:agro_smart/features/onboarding/screens/signup.dart';
// // import 'package:agro_smart/features/onboarding/widgets/my_text_field.dart';
// // import 'package:agro_smart/ui/molecules/custom_button.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:provider/provider.dart';

// // class LoginScreen extends StatefulWidget {
// //   const LoginScreen({super.key});

// //   @override
// //   State<LoginScreen> createState() => _LoginScreenState();
// // }

// // class _LoginScreenState extends State<LoginScreen> {
// //   final TextEditingController _emailController = TextEditingController();
// //   final TextEditingController _passwordController = TextEditingController();
// //   final _formKey1 = GlobalKey<FormState>();

// //   @override
// //   Widget build(BuildContext context) {
// //     // Ensure ScreenUtil is initialized in your main.dart or this context if using it
// //     // ScreenUtil.init(context);

// //     return Scaffold(
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: EdgeInsets.symmetric(horizontal: 40.w),
// //           child: Form(
// //             key: _formKey1,
// //             child: Consumer<OnboardingProvider>(
// //               builder: (context, value, child) => Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   SizedBox(height: 56.h),
// //                   Center(
// //                     child: Image.asset(
// //                       AppIcons.appLogo,
// //                       width: 145.w,
// //                       height: 144.h,
// //                     ),
// //                   ),
// //                   CustomSpacers.height60,
// //                   Text(
// //                     "Login with email",
// //                     style:
// //                         TextStyle(fontSize: 25.w, fontWeight: FontWeight.w600),
// //                     textAlign: TextAlign.left,
// //                   ),
// //                   CustomSpacers.height26,
// //                   MyTextfield(
// //                     labelText: "Email",
// //                     controller: _emailController,
// //                     validator: (v) {
// //                       if (v == null || v.isEmpty) {
// //                         return "Please enter email";
// //                       }
// //                       return null;
// //                     },
// //                   ),
// //                   CustomSpacers.height26,
// //                   MyTextfield(
// //                     labelText: "password",
// //                     controller: _passwordController,
// //                     type: TextInputType.emailAddress,
// //                     validator: (v) {
// //                       if (v == null || v.isEmpty) {
// //                         return "Please enter password";
// //                       }
// //                       return null;
// //                     },
// //                   ),
// //                   CustomSpacers.height20,
// //                   Text(
// //                     "Forgot Password?",
// //                     style: TextStyle(
// //                         color: Colors.green,
// //                         fontSize: 17.w,
// //                         fontWeight: FontWeight.w500),
// //                   ),
// //                   CustomSpacers.height20,
// //                   !value.isLoading
// //                       ? CustomButton(
// //                           strButtonText: "Log In",
// //                           buttonAction: () {
// //                             if (_formKey1.currentState!.validate()) {
// //                               // Process data.
// //                               value.login(_emailController.text,
// //                                   _passwordController.text, context);
// //                             }
// //                           },
// //                           dHeight: 69.h,
// //                           dWidth: 369.w,
// //                           bgColor: Colors.green,
// //                           dCornerRadius: 12,
// //                         )
// //                       : Center(
// //                           child: CircularProgressIndicator(),
// //                         ),
// //                   CustomSpacers.height16,
// //                   !value.isLoading
// //                       ? Center(
// //                           child: Text("Or",
// //                               style: TextStyle(
// //                                   fontSize: 20.w, fontWeight: FontWeight.w600)))
// //                       : Container(),
// //                   CustomSpacers.height16,
// //                   !value.isLoading
// //                       ? CustomButton(
// //                           strButtonText: "Login with Phone",
// //                           buttonAction: () {
// //                             Navigator.pushReplacement(
// //                                 context,
// //                                 MaterialPageRoute(
// //                                     builder: (context) =>
// //                                         LoginWithOtpScreen()));
// //                           },
// //                           dHeight: 69.h,
// //                           dWidth: 369.w,
// //                           bgColor: Colors.blue,
// //                           dCornerRadius: 12,
// //                         )
// //                       : Container(),
// //                   CustomSpacers.height20,
// //                   Row(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         'Don\'t have an Account? ',
// //                         style: TextStyle(
// //                             fontSize: 17.w, fontWeight: FontWeight.w300),
// //                       ),
// //                       GestureDetector(
// //                         onTap: () {
// //                           Navigator.pushReplacement(
// //                               context,
// //                               MaterialPageRoute(
// //                                   builder: (context) => SignUpScreen()));
// //                         }, // Assuming onTap is a callback passed to the widget
// //                         child: Text(
// //                           'Sign Up',
// //                           style: TextStyle(
// //                               color: Colors.green,
// //                               fontSize: 17.w,
// //                               fontWeight: FontWeight.w500),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }



// import 'dart:developer';

// import 'package:agro_smart/features/home/home.dart';
// import 'package:agro_smart/features/onboarding/screens/auth_service.dart';
// import 'package:agro_smart/features/onboarding/screens/signup.dart';
// import 'package:agro_smart/ui/custom_button.dart';
// import 'package:agro_smart/ui/custom_textfield.dart';
// import 'package:flutter/material.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _auth = AuthService();

//   final _email = TextEditingController();
//   final _password = TextEditingController();

//   @override
//   void dispose() {
//     super.dispose();
//     _email.dispose();
//     _password.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 25),
//         child: Column(
//           children: [
//             const Spacer(),
//             const Text("Login",
//                 style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),
//             const SizedBox(height: 50),
//             CustomTextField(
//               hint: "Enter Email",
//               label: "Email",
//               controller: _email,
//             ),
//             const SizedBox(height: 20),
//             CustomTextField(
//               hint: "Enter Password",
//               label: "Password",
//               controller: _password,
//             ),
//             const SizedBox(height: 30),
//             CustomButton(
//               label: "Login",
//               onPressed: _login,
//             ),
//             const SizedBox(height: 5),
//             Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//               const Text("Already have an account? "),
//               InkWell(
//                 onTap: () => goToSignup(context),
//                 child:
//                     const Text("Signup", style: TextStyle(color: Colors.red)),
//               )
//             ]),
//             const Spacer()
//           ],
//         ),
//       ),
//     );
//   }

//   goToSignup(BuildContext context) => Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const SignupScreen()),
//       );

//   goToHome(BuildContext context) => Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const HomeScreen()),
//       );

//   _login() async {
//     final user =
//         await _auth.loginUserWithEmailAndPassword(_email.text, _password.text);

//     if (user != null) {
//       log("User Logged In");
//       goToHome(context);
//     }
//   }
// }