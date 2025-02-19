// // // ignore_for_file: prefer_const_constructors

// // import 'package:agro_smart/core/constants/app_icons.dart';
// // import 'package:agro_smart/core/constants/value_constants.dart';
// // import 'package:agro_smart/core/loaded_widget.dart';
// // import 'package:agro_smart/core/utils/custom_spacers.dart';
// // import 'package:agro_smart/core/utils/screen_utils.dart';
// // import 'package:agro_smart/features/onboarding/data/onboarding_provider.dart';
// // import 'package:agro_smart/features/onboarding/screens/login.dart';
// // import 'package:agro_smart/features/onboarding/widgets/my_text_field.dart';
// // import 'package:agro_smart/ui/molecules/custom_button.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // // ignore: unnecessary_import
// // import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:provider/provider.dart';


// // class SignUpScreen extends StatefulWidget {
// //   const SignUpScreen({
// //     super.key,
// //   });

// //   @override
// //   State<SignUpScreen> createState() => _SignUpScreenState();
// // }

// // class _SignUpScreenState extends State<SignUpScreen> {
// //   final TextEditingController _nameController = TextEditingController();
// //   final TextEditingController _phoneController = TextEditingController();
// //   final TextEditingController _emailController = TextEditingController();
// //   final TextEditingController _passwordController = TextEditingController();
// //   final TextEditingController _confirmPasswordController =
// //       TextEditingController();
// //   final _formKey = GlobalKey<FormState>();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: EdgeInsets.symmetric(horizontal: 40.w),
// //           child: Consumer<OnboardingProvider>(
// //             builder: (context, value, child) => Form(
// //               key: _formKey,
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 mainAxisAlignment: MainAxisAlignment.start,
// //                 children: [
// //                   CustomSpacers.height56,
// //                   Center(
// //                     child: Image.asset(
// //                       AppIcons.appLogo,
// //                       width: 145.w,
// //                       height: 144.h,
// //                     ),
// //                   ),
// //                   CustomSpacers.height21,
// //                   Text(
// //                     "Sign Up",
// //                     style:
// //                         TextStyle(fontSize: 25.w, fontWeight: FontWeight.w600),
// //                     textAlign: TextAlign.left,
// //                   ),
// //                   CustomSpacers.height26,
// //                   MyTextfield(
// //                     labelText: "Name",
// //                     controller: _nameController,
// //                     validator: (v) {
// //                       if (v == null || v.isEmpty) {
// //                         return "Please Enter name";
// //                       }
// //                     },
// //                   ),
// //                   CustomSpacers.height26,
// //                   MyTextfield(
// //                     labelText: "Email",
// //                     controller: _emailController,
// //                     type: TextInputType.emailAddress,
// //                     validator: (v) {
// //                       if (v == null || v.isEmpty) {
// //                         return "Please enter email";
// //                       }
// //                       return null;
// //                     },
// //                   ),
// //                   CustomSpacers.height26,
// //                   MyTextfield(
// //                     labelText: "Phone Number",
// //                     controller: _phoneController,
// //                     type: TextInputType.number,
// //                     validator: (v) {
// //                       if (v == null || v.isEmpty) {
// //                         return "Please enter phone number";
// //                       }
// //                       return null;
// //                     },
// //                   ),
// //                   CustomSpacers.height26,
// //                   MyTextfield(
// //                     labelText: "Password",
// //                     controller: _passwordController,
// //                     validator: (v) {
// //                       if (v == null || v.isEmpty) {
// //                         return "Please enter password";
// //                       }
// //                       return null;
// //                     },
// //                   ),
// //                   CustomSpacers.height26,
// //                   MyTextfield(
// //                     labelText: "Confirm Password",
// //                     controller: _confirmPasswordController,
// //                     validator: (v) {
// //                       if (v == null || v.isEmpty) {
// //                         return "Please enter confirm password";
// //                       }
// //                       return null;
// //                     },
// //                   ),
// //                   CustomSpacers.height20,
// //                   Row(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         'Already have an Account? ',
// //                         style: TextStyle(
// //                             fontSize: 17.w, fontWeight: FontWeight.w300),
// //                       ),
// //                       GestureDetector(
// //                         onTap: () {
// //                           Navigator.pushReplacement(
// //                               context,
// //                               MaterialPageRoute(
// //                                   builder: (context) => LoginScreen()));
// //                         },
// //                         child: Text(
// //                           'Login',
// //                           style: TextStyle(
// //                               color: Colors.green,
// //                               fontSize: 17.w,
// //                               fontWeight: FontWeight.w500),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   CustomSpacers.height32,
// //                   !value.isLoading
// //                       ? CustomButton(
// //                           strButtonText: "Create Account",
// //                           buttonAction: () async {
// //                             if (_formKey.currentState!.validate()) {
// //                               if (_passwordController.text !=
// //                                   _confirmPasswordController.text) {
// //                                 OverlayManager.showToast(
// //                                     type: ToastType.Alert,
// //                                     msg: "Password must be same");
// //                               } else {
// //                                 await value.signup(
// //                                     _phoneController.text,
// //                                     context,
// //                                     _nameController.text,
// //                                     _emailController.text,
// //                                     _passwordController.text);
// //                               }
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
// //                   CustomSpacers.height40,
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
// import 'package:agro_smart/features/onboarding/screens/login.dart';
// import 'package:agro_smart/ui/custom_textfield.dart';
// import 'package:flutter/material.dart';

// import '../../../ui/custom_button.dart';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final _auth = AuthService();

//   final _name = TextEditingController();
//   final _email = TextEditingController();
//   final _password = TextEditingController();

//   @override
//   void dispose() {
//     super.dispose();
//     _name.dispose();
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
//             const Text("Signup",
//                 style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),
//             const SizedBox(
//               height: 50,
//             ),
//             CustomTextField(
//               hint: "Enter Name",
//               label: "Name",
//               controller: _name,
//             ),
//             const SizedBox(height: 20),
//             CustomTextField(
//               hint: "Enter Email",
//               label: "Email",
//               controller: _email,
//             ),
//             const SizedBox(height: 20),
//             CustomTextField(
//               hint: "Enter Password",
//               label: "Password",
//               isPassword: true,
//               controller: _password,
//             ),
//             const SizedBox(height: 30),
//             CustomButton(
//               label: "Signup",
//               onPressed: _signup,
//             ),
//             const SizedBox(height: 5),
//             Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//               const Text("Already have an account? "),
//               InkWell(
//                 onTap: () => goToLogin(context),
//                 child: const Text("Login", style: TextStyle(color: Colors.red)),
//               )
//             ]),
//             const Spacer()
//           ],
//         ),
//       ),
//     );
//   }

//   goToLogin(BuildContext context) => Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginScreen()),
//       );

//   goToHome(BuildContext context) => Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const HomeScreen()),
//       );

//   _signup() async {
//     final user =
//         await _auth.createUserWithEmailAndPassword(_email.text, _password.text);
//     if (user != null) {
//       log("User Created Succesfully");
//       goToHome(context);
//     }
//   }
// }
