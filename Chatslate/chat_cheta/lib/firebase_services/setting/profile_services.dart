import 'dart:io';
import 'package:chat_cheta/utils/allimports.dart';

class ProfileServices extends GetxController {
  RxBool isloading = false.obs;
  final namecontroller = TextEditingController();
  final aboutuscontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  RxString? imagepath = "".obs;
  File? image;

  Future<void> fetchUserData() async {
    final data = await getCurrentUserData();

    if (data != null) {
      imagepath!.value = data.image;
      namecontroller.text = data.name ?? "";
      aboutuscontroller.text = data.aboutus ?? "";
      emailcontroller.text = data.email ?? "";
    }
    update();
  }

  Future<void> pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage?.path != "" && pickedImage?.path != null) {
      image = File(pickedImage!.path);
      update();
    }
  }

  Future<dynamic> getCurrentUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.email)
          .get();
      return GetContactModel.fromSnapShot(snapshot);
    }
    return null;
  }

  Future<String> _uploadFile(String imagepath, File image) async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child('images/$imagepath');
    UploadTask uploadTask = storageReference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> updateUserData(
      String newName, String newAbout, String newEmail) async {
    isloading = true.obs;
    update();
    final user = FirebaseAuth.instance.currentUser;
    if (image?.path != "" && image?.path != null) {
      String path = await _uploadFile(
          "${user!.email}${DateTime.now().toString()}", image!);
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.email)
          .update({
        'image': path,
      });
    }

    if (user != null) {
      //FirebaseAuth.instance.currentUser!.updateEmail(newEmail);
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.email)
          .update({
        'name': newName,
        'aboutus': newAbout,
      });
      isloading = false.obs;
      update();
      Utils.toastMessage(
          "Successfully", "Profile updated successfully", buttoncolor);
    }
  }

  Future<void> updateUserLocale(String locale) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.email)
          .update({
        'locale': locale,
      });
      Utils.toastMessage("Updated", "Language Updated", buttoncolor);
    } catch (e) {
      Utils.toastMessage(
          "Error!", "Something went wrong try again later", buttoncolor);
    }
  }
}
