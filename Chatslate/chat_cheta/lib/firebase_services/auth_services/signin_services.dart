import 'package:chat_cheta/utils/allimports.dart';
import '../ChatService/PushNotificationService.dart';

class SignInServices extends GetxController {
  final formkeyy = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final pushNotification = Get.put(PushNotificationsService());
  FirebaseAuth _auth = FirebaseAuth.instance;
  RxBool isloading = false.obs;

  void IsSignIn() {
    isloading = true.obs;
    update();
    if (formkeyy.currentState!.validate()) {
      if (emailcontroller.text.isEmpty || passwordcontroller.text.isEmpty) {
        isloading = false.obs;
        update();
        // Display error message for empty fields
        Utils.toastMessage("Error", "Invalid Email and Password", Colors.red);
      } else {
        isloading = true.obs;
        update();
        // Proceed with Firebase authentication
        _auth
            .signInWithEmailAndPassword(
                email: emailcontroller.text.toString(),
                password: passwordcontroller.text.toString())
            .then((value) {
          isloading = false.obs;
          update();
          Get.offAll(MainScreen());
          emailcontroller.text = "";
          passwordcontroller.text = "";
          pushNotification.getFCMToken();
        }).catchError((error) {
          isloading = false.obs;
          update();
          Utils.toastMessage("Error", "Invalid Email and Password", Colors.red);
        });
      }
    }
  }
}
