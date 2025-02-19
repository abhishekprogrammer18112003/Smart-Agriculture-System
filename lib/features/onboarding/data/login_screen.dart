
import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_icons.dart';
import 'package:frontend/features/home/home.dart';
import 'package:frontend/features/onboarding/data/sign_up.dart';
import 'package:frontend/features/onboarding/screens/auth_service.dart';
import 'package:frontend/ui/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login(BuildContext context) async {
    try {
      await AuthService.login(_emailController.text, _passwordController.text);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => HomeScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
              onPressed: () => _login(context),
              child: Text("Login"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Text("Or login with"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // IconButton(
                //   onPressed: () {
                //     // Google login logic
                //   },
                //   // icon: Icon(Icons.google, color: Colors.red),d
                // ),
                // IconButton(
                //   onPressed: () {
                //     // Facebook login logic
                //   },
                //   icon: Icon(Icons.facebook, color: Colors.blue),
                // ),
              ],
            ),
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
    );
  }
}
