
import 'package:chat_cheta/utils/allimports.dart';

class SignupServices extends GetxController {
  final formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final namecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final pushNotification = Get.put(PushNotificationsService());
  RxBool isloading = false.obs;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void IsSignup() {
    isloading = true.obs;
    update();
    if (formkey.currentState!.validate()) {
      if (emailcontroller.text.isEmpty || passwordcontroller.text.isEmpty) {
        isloading = false.obs;
        update();
        // Display error message for empty fields
        Utils.toastMessage("Error", "Please fill in all fields", Colors.red);
      } else {
        isloading = true.obs;
        update();
        // Proceed with Firebase authentication
        _auth
            .createUserWithEmailAndPassword(
                email: emailcontroller.text.toString(),
                password: passwordcontroller.text.toString())
            .then((value) async {
          isloading = false.obs;
          update();
          _firestore.collection('Users').doc(_auth.currentUser!.email).set({
            "id": _auth.currentUser!.uid,
            "email": emailcontroller.text,
            "name": namecontroller.text,
            "image": " ",
            "aboutus": "I am using Chatslate",
            "lastMessage": "",
            "lastMessageTimeSpan": 0,
            "lastMessageDate": DateTime.now(),
            "fcmToken": "",
            "locale": "en",
            "isReaded": true,
          });
          Utils.toastMessage(
              "Successfully", "Register Successfully", buttoncolor);
          Get.to(MenuScreen());
          emailcontroller.text = "";
          passwordcontroller.text = "";
          namecontroller.text = "";
          pushNotification.getFCMToken();
        }).catchError((error) {
          isloading = false.obs;
          update();
          String errorMessage = error.toString();
          if (error is FirebaseAuthException) {
            errorMessage = error.message ?? 'An error occurred';
          }
          Utils.toastMessage("Error", errorMessage, Colors.red);
          print(errorMessage.toString());
        });
      }
    }
  }
}
