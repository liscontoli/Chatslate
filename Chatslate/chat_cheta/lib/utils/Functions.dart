import 'dart:convert';
import 'package:translator/translator.dart';
import 'package:chat_cheta/utils/allimports.dart';

handleBackGroundNotification(
    RemoteMessage message, BuildContext context) async {
  LocalNotificationService.display(message);
  final controller = Get.put(ContactServices());
  var model = await controller.getSingleUser();
  GetContactModel contactModel =
      GetContactModel.fromJson(json.decode(message.data["model"]));
  controller.updateReadeStatus();
  controller.getContacts();
}

void localNotificationInit(BuildContext context) {
  LocalNotificationService.initialize(context);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    if (currentUser != message.data["name"]) {
      handleBackGroundNotification(message, context);
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print("Calls");
  });
}

setNotifications() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  try {
    FirebaseMessaging.instance.getInitialMessage();
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
    } else {}
  } catch (e) {
    print(e.toString());
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  final controller = Get.put(ContactServices());
  var model = await controller.getSingleUser();
  GetContactModel contactModel =
      GetContactModel.fromJson(json.decode(message.data["model"]));
  controller.updateReadeStatus();
  controller.getContacts();
  LocalNotificationService.display(message);
  GetMaterialApp(
    builder: (context, child) {
      return ChatScreen(
        model: contactModel,
        currentUserLocale: model.locale!,
        userEmail: contactModel.email!,
      );
    },
  );
}

Future<String> translate(String val, String currentUserLang,
    {String? otherUserLang}) async {
  Translation? translation;
  final translator = GoogleTranslator();
  if (val == "") {
    return val;
  }
  try {
    translation = await translator.translate(val, to: currentUserLang);
  } catch (e) {}
  return translation?.text ?? "";
}
