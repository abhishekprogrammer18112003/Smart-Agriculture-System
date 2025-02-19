
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

import '../../home/home.dart';

class DynamicLinksService {
  static Future<void> handleDynamicLinks(BuildContext context) async {
    // Retrieve and handle any incoming dynamic links
    FirebaseDynamicLinks.instance.onLink.listen((PendingDynamicLinkData? dynamicLinkData) async {
      final Uri? deepLink = dynamicLinkData?.link;

      if (deepLink != null && deepLink.queryParameters.containsKey('oobCode')) {
        final String? oobCode = deepLink.queryParameters['oobCode'];

        try {
          // Verify the email with the oobCode
          await FirebaseAuth.instance.checkActionCode(oobCode!);
          await FirebaseAuth.instance.applyActionCode(oobCode);

          // Reload user to refresh email verification state
          await FirebaseAuth.instance.currentUser?.reload();

          if (FirebaseAuth.instance.currentUser?.emailVerified ?? false) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }
        } catch (e) {
          print('Error verifying email: $e');
        }
      }
    }).onError((error) {
      print('Error in dynamic link: $error');
    });
  }
}
