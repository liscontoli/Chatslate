import 'dart:convert';
import 'dart:io';
import 'package:chat_cheta/model/PushNotificationsModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

class PushNotificationsService extends GetxController {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  void onInit() {
    super.onInit();
  }

  final _serverToken =
      'AAAAsDPOR1Y:APA91bFDcFrClCtwXLdH3xT6m7iIygAEThtcBpPw2MO6m-0tTjdaJ0PQfFdJXxAL3KWLeOfUym-Aari-iGmEJa7m3c1LaHp2OpRK_R35d8BQawyqglsCzr6cc2YiYXw4oejagh8Hhm8Z';
  final fcmUrl = 'https://fcm.googleapis.com/fcm/send';
  Future<void> sendNotification(PushNotificationModel model) async {
    try {
      http.Response res = await http
          .post(Uri.parse(fcmUrl), body: json.encode(model.toJson()), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "key=$_serverToken"
      });
      print(res);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getFCMToken() async {
    String fcmToken = await FirebaseMessaging.instance.getToken() ?? "";
    _firestore
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({
      "fcmToken": fcmToken,
    });
  }
}
