import 'package:chat_cheta/utils/allimports.dart';

class ContactServices extends GetxController {
  @override
  void onInit() {
    getSingleUser();
    super.onInit();
  }

  RxBool isLoading = true.obs;
  RxBool loading = false.obs;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<GetContactModel> list = [];
  List<GetContactModel> contactlist = [];
  List<GetContactModel> searchedlist = [];

  Future<void> createChatHead(String otherUserEmail, String name) async {
    loading = true.obs;
    update();
    try {
      /// Get User
      var user = await _firebaseFirestore
          .collection('Users')
          .where(
            'email',
            isEqualTo: otherUserEmail,
          )
          .get();

      var currentuser = await _firebaseFirestore
          .collection('Users')
          .doc(_auth.currentUser!.email)
          .get();

      var currentuserMap = currentuser.data();

      /// User exists check
      if (user.docs.isEmpty) {
        loading = false.obs;
        update();
        Utils.toastMessage('Not Founded!', 'User does not exists', Colors.red);
        return;
      }

      //Get Chat Head of user
      var resp = await _firebaseFirestore
          .collection('ChatHead')
          .doc(_auth.currentUser!.email)
          .get();

      // For Current User
      if (!resp.exists) {
        _firebaseFirestore
            .collection('ChatHead')
            .doc(_auth.currentUser!.email)
            .set({
          "userEmail": _auth.currentUser!.email,
          "Users": [
            {'email': otherUserEmail, 'isDeleted': false, 'nickName': name}
          ]
        });
      } else {
        _firebaseFirestore
            .collection('ChatHead')
            .doc(_auth.currentUser!.email)
            .update({
          "Users": FieldValue.arrayUnion([
            {'email': otherUserEmail, 'isDeleted': false, 'nickName': name}
          ])
        });
      }

      //Get Chat Head of user
      var otherresp = await _firebaseFirestore
          .collection('ChatHead')
          .doc(otherUserEmail)
          .get();
      // For Current User
      if (!otherresp.exists) {
        _firebaseFirestore.collection('ChatHead').doc(otherUserEmail).set({
          "userEmail": otherUserEmail,
          "Users": [
            {
              'email': _auth.currentUser!.email,
              'isDeleted': false,
              'nickName': currentuserMap?['name'].toString()
            }
          ]
        });
      } else {
        _firebaseFirestore.collection('ChatHead').doc(otherUserEmail).update({
          "Users": FieldValue.arrayUnion([
            {
              'email': _auth.currentUser!.email,
              'isDeleted': false,
              'nickName': currentuserMap?['name'].toString()
            }
          ])
        });
      }

      //  Get.back();
    } catch (e) {
      loading = false.obs;
      update();
      Utils.toastMessage('Internal Server Error!',
          'Something wen\'t wrong please try again later', Colors.red);
      return;
    }
    loading = false.obs;
    update();
    Utils.toastMessage(
        'Successfully', 'Contact Added successfully', buttoncolor);

    update();
  }

  Future<void> createContact(String otherUserEmail, String name) async {
    loading = true.obs;
    update();
    try {
      var user = await _firebaseFirestore
          .collection('Users')
          .where(
            'email',
            isEqualTo: otherUserEmail,
          )
          .get();

      var currentuser = await _firebaseFirestore
          .collection('Users')
          .doc(_auth.currentUser!.email)
          .get();

      var currentuserMap = currentuser.data();

      if (user.docs.isEmpty) {
        loading = false.obs;
        update();
        Utils.toastMessage('Not Founded!', 'User does not exists', Colors.red);
        return;
      }
      //Get Chat Head of user
      var resp = await _firebaseFirestore
          .collection('Contact')
          .doc(_auth.currentUser!.email)
          .get();
      // For Current User
      if (!resp.exists) {
        _firebaseFirestore
            .collection('Contact')
            .doc(_auth.currentUser!.email)
            .set({
          "userEmail": _auth.currentUser!.email,
          "Users": [
            {'email': otherUserEmail, 'nickName': name.toString()}
          ]
        });
      } else {
        _firebaseFirestore
            .collection('Contact')
            .doc(_auth.currentUser!.email)
            .update({
          "Users": FieldValue.arrayUnion([
            {'email': otherUserEmail, 'nickName': name.toString()}
          ])
        });
      }

      //Get Chat Head of user
      var otherresp = await _firebaseFirestore
          .collection('Contact')
          .doc(otherUserEmail)
          .get();
      // For Current User
      if (!otherresp.exists) {
        _firebaseFirestore.collection('Contact').doc(otherUserEmail).set({
          "userEmail": otherUserEmail,
          "Users": [
            {
              'email': _auth.currentUser!.email,
              'nickName': currentuserMap?['name'].toString()
            }
          ]
        });
      } else {
        _firebaseFirestore.collection('Contact').doc(otherUserEmail).update({
          "Users": FieldValue.arrayUnion([
            {
              'email': _auth.currentUser!.email,
              'nickName': currentuserMap?['name'].toString()
            }
          ])
        });
      }

      //  Get.back();
    } catch (e) {
      loading = false.obs;
      update();
      Utils.toastMessage('Internal Server Error!',
          'Something wen\'t wrong please try again later', Colors.red);
      return;
    }
    loading = false.obs;
    update();
    Utils.toastMessage(
        'Successfully', 'Contact Added successfully', buttoncolor);

    update();
    Get.off(ContactScreen());
  }

  void updateReadeStatus() {
    _firebaseFirestore
        .collection('Users')
        .doc(_auth.currentUser!.email)
        .update({'isReaded': true});
    update();
  }

  Future<bool> isUserExist(String email) async {
    DocumentSnapshot snapshot = await _firebaseFirestore
        .collection('Contact')
        .doc(_auth.currentUser!.email)
        .get();
    if (!snapshot.exists) {
      return true;
    }
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    var users = data['Users'] as List<dynamic>;
    if (_auth.currentUser!.email == email) {
      Utils.toastMessage('Own Account',
          'You cannot add your own account in chat!', Colors.red);

      return false;
    }
    var user = users.any((e) => e == email);

    if (user) {
      Utils.toastMessage(
          'Already Exists!', 'This user is already in you contact', Colors.red);

      return false;
    } else {
      return true;
    }
  }

  void searchContacts(String val) {
    if (val == "") {
      searchedlist = list;
    } else {
      searchedlist = list
          .where((element) =>
              element.email!.contains(val) || element.name!.contains(val))
          .toList();
    }
    update();
  }

  Future<void> getContacts() async {
    var users = await _firebaseFirestore
        .collection('Contact')
        .doc(_auth.currentUser!.email)
        .get();
    list = [];
    update();
    if (!users.exists) {
      isLoading.value = false;
      update();
      return;
    }
    Map<String, dynamic> mappedUsers = users.data()!;
    if (mappedUsers['Users'] == null) {
      isLoading.value = false;
      update();
      return;
    }
    for (var user in mappedUsers['Users']) {
      isLoading.value = false;
      update();
      var fetchedUser =
          await _firebaseFirestore.collection('Users').doc(user['email']).get();
      if (fetchedUser.exists) {
        var convertedData = GetContactModel.fromSnapShot(fetchedUser);
        if (user['nickName'] != null && user['nickName'] != "") {
          convertedData.name = user['nickName'];
        }
        list.add(convertedData);
        //Assign Values to model
      }
    }

    list.toSet();
    searchedlist = list;
    isLoading.value = false;
    update();
  }

  Future<GetContactModel> getSingleUser() async {
    DocumentSnapshot snapshot = await _firebaseFirestore
        .collection("Users")
        .doc(_auth.currentUser!.email)
        .get();
    return GetContactModel.fromSnapShot(snapshot);
  }

  Future<void> getContactsForChats() async {
    var users = await _firebaseFirestore
        .collection('ChatHead')
        .doc(_auth.currentUser!.email)
        .get();
    contactlist = [];
    update();
    if (!users.exists) {
      isLoading.value = false;
      update();
      return;
    }
    Map<String, dynamic> mappedUsers = users.data()!;
    if (mappedUsers['Users'] == null) {
      isLoading.value = false;
      update();
      return;
    }
    for (var user in mappedUsers['Users']) {
      isLoading.value = false;
      update();
      var fetchedUser =
          await _firebaseFirestore.collection('Users').doc(user['email']).get();
      if (fetchedUser.exists) {
        if (!user['isDeleted']) {
          var convertedData = GetContactModel.fromSnapShot(fetchedUser);
          if (user['nickName'] != null && user['nickName'] != "") {
            convertedData.name = user['nickName'];

            contactlist.add(convertedData);
          }
          //Assign Values to model
        }
      }
      contactlist.toSet();
      contactlist.sort((a, b) {
        isLoading.value = false;
        update();
        try {
          return a.lastMessageTimeSpan!.compareTo(b.lastMessageTimeSpan!);
        } catch (e) {
          return 0;
        }
      });
      isLoading.value = false;
      update();
    }
  }
}
