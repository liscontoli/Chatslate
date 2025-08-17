import 'package:chat_cheta/utils/allimports.dart';

class GetContactModel {
  String? aboutus;
  String? email;
  String? fcmToken;
  String? id;
  String? image;
  String? name;
  String? lastMessage;
  int? lastMessageTimeSpan;
  String? lastMessageDate;
  String? locale;
  bool? isReaded;

  GetContactModel(
      {this.lastMessageTimeSpan,
      this.lastMessage,
      this.aboutus,
      this.isReaded,
      this.fcmToken,
      this.email,
      this.locale,
      this.lastMessageDate,
      this.id,
      this.image,
      this.name});

  GetContactModel.fromSnapShot(DocumentSnapshot snapshot) {
    aboutus = snapshot['aboutus'];
    email = snapshot['email'];
    isReaded = snapshot['isReaded'];
    locale = snapshot['locale'];
    id = snapshot['id'];
    fcmToken = snapshot['fcmToken'];
    image = snapshot['image'];
    name = snapshot['name'];
    lastMessage = snapshot['lastMessage'];
    lastMessageTimeSpan = snapshot['lastMessageTimeSpan'];
    lastMessageDate = snapshot['lastMessageDate'].toString();
  }

  GetContactModel.fromJson(Map<String, dynamic> json) {
    aboutus = json['aboutus'];
    email = json['email'];
    fcmToken = json['fcmToken'];
    id = json['id'];
    image = json['image'];
    name = json['name'];
    lastMessage = json['lastMessage'];
    lastMessageTimeSpan = json['lastMessageTimeSpan'];
    lastMessageDate = json['lastMessageDate'];
    locale = json['locale'];
    isReaded = json['isReaded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aboutus'] = this.aboutus;
    data['email'] = this.email;
    data['fcmToken'] = this.fcmToken;
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['lastMessage'] = this.lastMessage;
    data['lastMessageTimeSpan'] = this.lastMessageTimeSpan;
    data['lastMessageDate'] = this.lastMessageDate;
    data['locale'] = this.locale;
    data['isReaded'] = this.isReaded;
    return data;
  }
}
