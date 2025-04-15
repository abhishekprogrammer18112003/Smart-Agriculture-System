// ignore_for_file: unnecessary_import

import 'package:frontend/core/app_imports.dart';
import 'package:frontend/core/loaded_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingProvider with ChangeNotifier {
  bool _isSendingOtp = false;
  bool get isSendingOtp => _isSendingOtp;

  //SEND OTP
  Future<bool> sendOtp(String email) async {
    _isSendingOtp = true;
    notifyListeners();

    try {
      var headers = {'Content-Type': 'application/json'};
      Map<String, dynamic> body = {
        "email": email,
      };
      http.Response response = await http.post(Uri.parse(SEND_OTP),
          headers: headers, body: jsonEncode(body));
      var data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        OverlayManager.showToast(
            type: ToastType.Success, msg: data["message"].toString());
        print(data["message"].toString());

        _isSendingOtp = false;
        notifyListeners();
        if (data["message"] == "OTP sent to email.") {
          return true;
        }
        return false;
      } else {
        print("else");

        _isSendingOtp = false;
        notifyListeners();

        // OverlayManager.showToast(type: ToastType.Error, msg: data.toString());
        return false;
        // throw data["message"];
      }
    } catch (e) {
      print(e.toString());
      OverlayManager.showToast(type: ToastType.Error, msg: e.toString());
      _isSendingOtp = false;
      notifyListeners();
      return false;
      rethrow;
    }
  }

//VERIFY OTP
  Future<bool> verifyOtp(String email, String otp, String username,
      String password, String apiKey) async {
    _isSendingOtp = true;
    notifyListeners();

    try {
      var headers = {'Content-Type': 'application/json'};
      Map<String, dynamic> body = {
        "apiKey": apiKey,
        "userName": username,
        "email": email,
        "password": password,
        "otp": otp
      };
      http.Response response = await http.post(Uri.parse(VERIFY_OTP),
          headers: headers, body: jsonEncode(body));
      var data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        OverlayManager.showToast(
            type: ToastType.Success, msg: data["message"].toString());

        _isSendingOtp = false;
        notifyListeners();

        if (data["message"] == "User registered successfully.") {
          return true;
        }
        return false;
      } else {
        _isSendingOtp = false;
        notifyListeners();

        // OverlayManager.showToast(type: ToastType.Error, msg: data.toString());
        return false;
        // throw data["message"];
      }
    } catch (e) {
      OverlayManager.showToast(type: ToastType.Error, msg: e.toString());
      _isSendingOtp = false;
      notifyListeners();
      return false;
      rethrow;
    }
  }

  //VERIFY OTP
  Future<bool> login(String email, String password) async {
    _isSendingOtp = true;
    notifyListeners();

    try {
      var headers = {'Content-Type': 'application/json'};
      Map<String, dynamic> body = {"email": email, "password": password};
      http.Response response = await http.post(Uri.parse(LOGIN),
          headers: headers, body: jsonEncode(body));
      var data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        OverlayManager.showToast(
            type: ToastType.Success, msg: data["message"].toString());

        _isSendingOtp = false;
        notifyListeners();

        if (data["message"] == "Login successful.") {
          return true;
        }
        return false;
      } else {
        _isSendingOtp = false;
        notifyListeners();

        // OverlayManager.showToast(type: ToastType.Error, msg: data.toString());
        return false;
        // throw data["message"];
      }
    } catch (e) {
      OverlayManager.showToast(type: ToastType.Error, msg: e.toString());
      _isSendingOtp = false;
      notifyListeners();
      return false;
      rethrow;
    }
  }
}
