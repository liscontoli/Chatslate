import 'dart:async';
import 'package:chat_cheta/model/GetContactsModel.dart';
import 'package:chat_cheta/model/PushNotificationsModel.dart';
import 'package:chat_cheta/utils/Functions.dart';
import 'package:flutter/material.dart' as a;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../model/ChatModel.dart';
import '../../utils/color.dart';
import '../../utils/toast.dart';
import '../main_services/contact_services.dart';
import 'PushNotificationService.dart';

class ChatService {
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final pushNotification = Get.put(PushNotificationsService());
  final contactNotification = Get.put(ContactServices());
  Stream<List<ChatModel>> getMessagesInRealTime(
      String? otherUserEmail, String? currentuserEmail) {
    // ignore: close_sinks
    final StreamController<List<ChatModel>> _chatMessages =
        StreamController<List<ChatModel>>.broadcast();
    Query<Map<String, dynamic>> messageQuerySnapshot =
        _fireStore.collection('Chat').orderBy('TimeSpan', descending: true);

    messageQuerySnapshot.snapshots().listen((messageEvent) {
      if (messageEvent.docs.isNotEmpty) {
        var messages = messageEvent.docs
            .map((item) => ChatModel.fromSnapShot(item))
            .where((element) =>
                (element.reciverEmail!.toLowerCase() ==
                        otherUserEmail!.toLowerCase() &&
                    element.senderEmail!.toLowerCase() ==
                        currentuserEmail!.toLowerCase()) ||
                (element.reciverEmail!.toLowerCase() ==
                        currentuserEmail!.toLowerCase() &&
                    element.senderEmail!.toLowerCase() ==
                        otherUserEmail.toLowerCase()))
            .toList();

        _chatMessages.add(messages);
      }
    });
    return _chatMessages.stream;
  }

  Future<void> deleteUserChats(String? otherUserEmail) async {
    try {
      QuerySnapshot snapshot = await _fireStore.collection('Chat').get();
      List<ChatModel> model = snapshot.docs
          .map((e) => ChatModel.fromSnapShot(e))
          .where((element) =>
              (element.reciverEmail!.toLowerCase() ==
                      otherUserEmail!.toLowerCase() &&
                  element.senderEmail!.toLowerCase() ==
                      _auth.currentUser!.email!.toLowerCase()) ||
              (element.reciverEmail!.toLowerCase() ==
                      _auth.currentUser!.email!.toLowerCase() &&
                  element.senderEmail!.toLowerCase() ==
                      otherUserEmail.toLowerCase()))
          .toList();
      if (model.length > 0) {
        DocumentSnapshot snapshot = await _fireStore
            .collection('ChatHead')
            .doc(_auth.currentUser!.email)
            .get();
        Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;

        for (var user in map['Users']) {
          if (user['email'].toString().toLowerCase() ==
              otherUserEmail!.toLowerCase()) {
            user['isDeleted'] = true;
          }
        }
        await _fireStore
            .collection('ChatHead')
            .doc(_auth.currentUser!.email)
            .set(map);
        for (var chat in model) {
          _fireStore.collection('Chat').doc(chat.snapshotId).update({
            'deletedBy': FieldValue.arrayUnion(
                [DeletedBy(userEmail: _auth.currentUser!.email).toJson()]),
          });
        }
        Utils.toastMessage(
            'Deleted!', 'Chat deleted successfully', buttoncolor);
      } else {
        Utils.toastMessage('Error!', 'Not Chat\'s', buttoncolor);
      }
      contactNotification.getContactsForChats();
    } catch (e) {
      Utils.toastMessage('Internal Server Error!',
          'Something wen\'t wrong please try again later', a.Colors.red);
    }
  }

  void updateMessage(String doc) {
    _fireStore.collection('Chat').doc(doc).update({"isRead": true});
  }

  Stream<ChatModel> getLastMessage(String senderEmail, String reciverEmail) {
    // ignore: close_sinks
    final StreamController<ChatModel> _chatMessages =
        StreamController<ChatModel>.broadcast();
    Query<Map<String, dynamic>> messageQuerySnapshot =
        _fireStore.collection('Chat').orderBy('TimeSpan', descending: false);
    messageQuerySnapshot.snapshots().listen((messageEvent) {
      if (messageEvent.docs.isNotEmpty) {
        var messages = messageEvent.docs
            .map((item) => ChatModel.fromSnapShot(item))
            .lastWhere(
              (x) =>
                  // ignore: unrelated_type_equality_checks
                  (x.reciverEmail!.toLowerCase() ==
                          reciverEmail.toLowerCase() &&
                      x.senderEmail!.toLowerCase() ==
                          senderEmail.toLowerCase()) ||
                  // ignore: unrelated_type_equality_checks
                  (x.reciverEmail!.toLowerCase() == senderEmail.toLowerCase() &&
                      x.senderEmail!.toLowerCase() ==
                          reciverEmail.toLowerCase()),
              orElse: () => ChatModel(),
            );

        _chatMessages.add(messages);
      }
    });
    return _chatMessages.stream;
  }

  Future<void> addChat(ChatModel model, GetContactModel contactModel) async {
    DocumentSnapshot snapshot1 = await _fireStore
        .collection('ChatHead')
        .doc(_auth.currentUser!.email)
        .get();

    Map<String, dynamic> map = snapshot1.data() as Map<String, dynamic>;

    for (var user in map['Users']) {
      if (user['email'].toString().toLowerCase() ==
          model.reciverEmail!.toLowerCase()) {
        user['isDeleted'] = false;
      }
    }
    await _fireStore
        .collection('ChatHead')
        .doc(_auth.currentUser!.email)
        .set(map);

    DocumentSnapshot snapshot =
        await _fireStore.collection('Users').doc(model.senderEmail).get();
    DocumentSnapshot revicersnapshot =
        await _fireStore.collection('Users').doc(model.reciverEmail).get();

    GetContactModel contactModel = GetContactModel.fromSnapShot(snapshot);
    GetContactModel recivercontactModel =
        GetContactModel.fromSnapShot(revicersnapshot);
    _fireStore.collection('Users').doc(model.reciverEmail).update({
      'lastMessage': model.messageBody,
      'lastMessageTimeSpan': model.timeSpan,
      'lastMessageDate': model.dateTime,
      'isReaded': false
    });
    String message = await translate(
        model.messageBody.toString(), recivercontactModel.locale.toString());

    model.reciverLocale = contactModel.locale;
    var toJson = model.toSnapShot();
    _fireStore.collection('Chat').doc().set(toJson);
    _fireStore.collection('Users').doc(model.senderEmail).update({
      'lastMessage': model.messageBody,
      'lastMessageTimeSpan': model.timeSpan,
      'lastMessageDate': model.dateTime,
    });

    pushNotification.sendNotification(
      PushNotificationModel(
        notification: Notification(title: contactModel.name, body: message),
        priority: "high",
        to: model.fcmToken,
        data: {
          "name": contactModel.name,
          "model": contactModel.toJson(),
        },
      ),
    );
    contactNotification.getContacts();
    contactNotification.getContactsForChats();
  }
}
