import 'package:chat_cheta/utils/allimports.dart';

class ChatModel {
  String? fcmToken;
  String? snapshotId;
  String? senderEmail;
  String? reciverEmail;
  String? dateTime;
  int? timeSpan;
  String? messageBody;
  String? senderLocale;
  String? reciverLocale;
  bool? isRead;
  List<DeletedBy>? deletedBy;

  ChatModel({
    this.isRead,
    this.senderLocale,
    this.reciverLocale,
    this.fcmToken,
    this.senderEmail,
    this.reciverEmail,
    this.dateTime,
    this.timeSpan,
    this.messageBody,
  });

  ChatModel.fromSnapShot(DocumentSnapshot snapShot) {
    snapshotId = snapShot.id;
    isRead = snapShot["isRead"];
    dateTime = snapShot['DateTime'];
    senderLocale = snapShot['senderLocale'];
    reciverLocale = snapShot['reciverLocale'];
    timeSpan = snapShot['TimeSpan'];
    senderEmail = snapShot['senderEmail'];
    reciverEmail = snapShot['reciverEmail'];
    messageBody = snapShot['MessageBody'];
    if (snapShot['deletedBy'] != null) {
      deletedBy = <DeletedBy>[];
      snapShot['deletedBy'].forEach((v) {
        deletedBy!.add(new DeletedBy.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toSnapShot() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DateTime'] = dateTime;
    data['TimeSpan'] = timeSpan;
    data['isRead'] = false;
    data['senderLocale'] = senderLocale;
    data['reciverLocale'] = reciverLocale;
    data['MessageBody'] = messageBody;
    data['senderEmail'] = senderEmail;
    data['reciverEmail'] = reciverEmail;
    if (this.deletedBy != null) {
      data['deletedBy'] = this.deletedBy!.map((v) => v.toJson()).toList();
    } else {
      data['deletedBy'] = null;
    }
    return data;
  }
}

class DeletedBy {
  String? userEmail;

  DeletedBy({this.userEmail});

  DeletedBy.fromJson(Map<String, dynamic> json) {
    userEmail = json['userEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userEmail'] = this.userEmail;
    return data;
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';

// class ChatModel {
//   String? fcmToken;
//   String? snapshotId;
//   String? senderEmail;
//   String? reciverEmail;
//   String? dateTime;
//   int? timeSpan;
//   String? messageBody;
//   List<DeletedBy>? deletedBy;

//   ChatModel(
//       {this.fcmToken,
//       this.snapshotId,
//       this.senderEmail,
//       this.reciverEmail,
//       this.dateTime,
//       this.timeSpan,
//       this.messageBody,
//       this.deletedBy});

//   ChatModel.fromSnapShot(DocumentSnapshot json) {
//     fcmToken = json['fcmToken'];
//     snapshotId = json.id;
//     senderEmail = json['senderEmail'];
//     reciverEmail = json['reciverEmail'];
//     //dateTime = json['dateTime'];
//     timeSpan = json['timeSpan'];
//     messageBody = json['messageBody'];
//     if (json['deletedBy'] != null) {
//       deletedBy = <DeletedBy>[];
//       json['deletedBy'].forEach((v) {
//         deletedBy!.add(new DeletedBy.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toSnapShot() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['senderEmail'] = this.senderEmail;
//     data['reciverEmail'] = this.reciverEmail;
//     data['dateTime'] = this.dateTime;
//     data['timeSpan'] = this.timeSpan;
//     data['messageBody'] = this.messageBody;
//     if (this.deletedBy != null) {
//       data['deletedBy'] = this.deletedBy!.map((v) => v.toJson()).toList();
//     } else {
//       data['deletedBy'] = [];
//     }
//     return data;
//   }
// }

// class DeletedBy {
//   String? userEmail;

//   DeletedBy({this.userEmail});

//   DeletedBy.fromJson(DocumentSnapshot json) {
//     userEmail = json['userEmail'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['userEmail'] = this.userEmail;
//     return data;
//   }
// }
