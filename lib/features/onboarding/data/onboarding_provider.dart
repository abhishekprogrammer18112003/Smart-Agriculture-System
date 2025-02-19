// ignore_for_file: unnecessary_import

import 'package:frontend/core/app_imports.dart';
import 'package:frontend/core/loaded_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class OnboardingProvider with ChangeNotifier {
  bool _isSendingOtp = false;
  bool get isSendingOtp => _isSendingOtp;
  Future<void> sendOtp(String email) async {
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
        OverlayManager.showToast(type: ToastType.Success, msg: data.toString());

        _isSendingOtp = false;
        notifyListeners();
      } else {
        _isSendingOtp = false;
        notifyListeners();

        OverlayManager.showToast(type: ToastType.Error, msg: data.toString());
        // throw data["message"];
      }
    } catch (e) {
      OverlayManager.showToast(type: ToastType.Error, msg: e.toString());
      _isSendingOtp = false;
      notifyListeners();
      rethrow;
    }
  }
}
