import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_icons.dart';
import 'package:frontend/features/home/home.dart';
import 'package:frontend/features/onboarding/data/onboarding_provider.dart';
import 'package:frontend/features/onboarding/data/sign_up.dart';
import 'package:frontend/ui/custom_textfield.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                "Welcome Back!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text("Login to your account"),
              SizedBox(height: 30),
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
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Forgot password logic
                  },
                  child: Text("Forgot Password?"),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  bool isLogin = await value.login(
                      _emailController.text.toString(),
                      _passwordController.text.toString());

                  if (isLogin) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => HomeScreen(),
                      ),
                    );
                  }
                },
                child: !value.isSendingOtp
                    ? Text("Login")
                    : CircularProgressIndicator(),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => SignupScreen()),
                      );
                    },
                    child: Text("Sign Up"),
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
