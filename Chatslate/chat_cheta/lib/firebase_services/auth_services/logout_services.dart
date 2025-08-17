import 'package:chat_cheta/utils/allimports.dart';

class LogoutServices extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  void logout(BuildContext context) async {
    try {
      FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .update({
        "fcmToken": "",
      });
      await _auth.signOut();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MenuScreen()));
    } catch (error) {
      String errorMessage = error.toString();
      if (error is FirebaseAuthException) {
        errorMessage = error.message ?? 'An error occurred';
      }
      Utils.toastMessage("Error", errorMessage, Colors.red);
    }
  }
}
