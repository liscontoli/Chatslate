import 'dart:async';
import 'package:chat_cheta/utils/allimports.dart';

class SplashServices {
  FirebaseAuth _auth = FirebaseAuth.instance;

  void islogin(BuildContext context) {
    if (_auth.currentUser != null) {
      Timer(Duration(seconds: 3), () {
        Get.offAll(MainScreen());
      });
    } else {
      Timer(Duration(seconds: 3), () {
        Get.offAll(MenuScreen());
      });
    }
  }
}
