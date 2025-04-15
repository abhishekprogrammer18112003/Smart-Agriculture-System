import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_icons.dart';
import 'package:frontend/features/onboarding/data/onboarding_provider.dart';
import 'package:frontend/features/onboarding/data/otp_verification_page.dart';
import 'package:frontend/features/onboarding/screens/auth_service.dart';
import 'package:frontend/ui/custom_textfield.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _uniqueController = TextEditingController();

  // void _signup(BuildContext context) async {
  //   try {
  //     // await AuthService.signUp(_emailController.text, _passwordController.text);
  //     await p.sendOtp(_emailController.text);

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Check your email for OTP verification.")),
  //     ); // Return to login screen
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text(e.toString())),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<OnboardingProvider>(
          builder: (context, value, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Image.asset(AppIcons.appLogo, height: 100),
              SizedBox(height: 20),
              Text(
                "Create an Account",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text("Sign up to get started"),
              SizedBox(height: 30),
              CustomTextField(
                controller: _usernameController,
                hintText: "Username",
                icon: Icons.supervised_user_circle_sharp,
                // isPassword: false,
              ),
              CustomTextField(
                controller: _emailController,
                hintText: "Email",
                icon: Icons.email,
              ),
              CustomTextField(
                controller: _passwordController,
                hintText: "Password",
                icon: Icons.lock,
                isPassword: true,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  "*Note:  This is a unique key assigned to every system through which farmers can access the data.",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              CustomTextField(
                controller: _uniqueController,
                hintText: "Unique ID",
                icon: Icons.input_rounded,
                isPassword: false,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  bool a = await value.sendOtp(_emailController.text);

                  if (a) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (ctx) => OtpVerificationScreen(
                                uniqueId: _uniqueController.text.toString(),
                                email: _emailController.text.toString(),
                                password: _passwordController.text.toString(),
                                username: _usernameController.text.toString(),
                              )),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: !value.isSendingOtp
                    ? Text("Verify")
                    : CircularProgressIndicator(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Login"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
