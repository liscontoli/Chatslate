import 'package:chat_cheta/utils/allimports.dart';



class Utils {

    static toastMessage(String Tilte ,String message,Color color){
      Get.snackbar(
        Tilte,
        message,
        colorText: Colors.white,
        backgroundColor: color ?? Colors.orange,
      );
    }

}