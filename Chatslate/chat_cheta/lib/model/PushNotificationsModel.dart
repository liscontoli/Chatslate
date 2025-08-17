class PushNotificationModel {
  Notification? notification;
  String? priority;
  var data;
  String? to;

  PushNotificationModel({this.notification, this.priority, this.data, this.to});

  PushNotificationModel.fromJson(Map<String, dynamic> json) {
    notification = json['notification'] != null
        ? Notification.fromJson(json['notification'])
        : null;
    priority = json['priority'];
    data = json['data'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notification != null) {
      data['notification'] = notification!.toJson();
    }
    data['priority'] = priority;
    data['data'] = this.data;
    data['to'] = to;
    return data;
  }
}

class Notification {
  String? body;
  String? title;

  Notification({this.body, this.title});

  Notification.fromJson(Map<String, dynamic> json) {
    body = json['body'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['body'] = body;
    data['title'] = title;
    return data;
  }
}
