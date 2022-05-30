import 'package:rooya/Models/UserDataModel.dart';

class UserChatModel {
  int? apiStatus;
  List<Messages>? messages = <Messages>[];
  int? typing;
  int? isRecording;

  UserChatModel({this.apiStatus, this.messages, this.typing, this.isRecording});

  UserChatModel.fromJson(Map<String, dynamic> json) {
    apiStatus = json['api_status'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
    typing = json['typing'];
    isRecording = json['is_recording'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_status'] = this.apiStatus;
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    data['typing'] = this.typing;
    data['is_recording'] = this.isRecording;
    return data;
  }
}

class Messages {
  String? id;
  String? fromId;
  String? groupId;
  String? pageId;
  String? toId;
  String? text;
  String? media;
  String? mediaFileName;
  String? mediaFileNames;
  String? time;
  String? seen;
  String? deletedOne;
  String? deletedTwo;
  String? sentPush;
  String? notificationId;
  String? typeTwo;
  String? stickers;
  String? productId;
  String? lat;
  String? lng;
  String? replyId;
  String? storyId;
  String? broadcastId;
  String? forward;
  String? listening;
  String? delivered;
  MessageUser? messageUser;
  String? pin;
  String? fav;
  // List<Null>? reply;
  // List<Null>? story;
  Reaction? reaction;
  String? timeText;
  String? position;
  String? type;
  String? product;
  String? fileSize;
  UserData? userData;

  Messages(
      {this.id,
      this.fromId,
      this.groupId,
      this.pageId,
      this.toId,
      this.text,
      this.media,
      this.mediaFileName,
      this.mediaFileNames,
      this.time,
      this.seen,
      this.deletedOne,
      this.deletedTwo,
      this.sentPush,
      this.notificationId,
      this.typeTwo,
      this.stickers,
      this.productId,
      this.lat,
      this.lng,
      this.replyId,
      this.storyId,
      this.broadcastId,
      this.forward,
      this.listening,
      this.delivered,
      this.messageUser,
      this.pin,
      this.fav,
      // this.reply,
      // this.story,
      this.reaction,
      this.timeText,
      this.position,
      this.type,
      this.product,
      this.userData,
      this.fileSize});

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    fromId = json['from_id'].toString();
    groupId = json['group_id'].toString();
    pageId = json['page_id'].toString();
    toId = json['to_id'].toString();
    text = json['text'].toString();
    media = json['media'].toString();
    mediaFileName = json['mediaFileName'].toString();
    mediaFileNames = json['mediaFileNames'].toString();
    time = json['time'].toString();
    seen = json['seen'].toString();
    deletedOne = json['deleted_one'].toString();
    deletedTwo = json['deleted_two'].toString();
    sentPush = json['sent_push'].toString();
    notificationId = json['notification_id'].toString();
    typeTwo = json['type_two'].toString();
    stickers = json['stickers'].toString();
    productId = json['product_id'].toString();
    lat = json['lat'].toString();
    lng = json['lng'].toString();
    replyId = json['reply_id'].toString();
    storyId = json['story_id'].toString();
    broadcastId = json['broadcast_id'].toString();
    forward = json['forward'].toString();
    listening = json['listening'].toString();
    delivered = json['delivered'].toString();
    messageUser = json['messageUser'] != null
        ? new MessageUser.fromJson(json['messageUser'])
        : null;
    if (json.containsKey('user_data')) {
      if (json['user_data'] != null && json['user_data'] != false) {
        userData = UserData.fromJson(json['user_data']);
      }
    }
    pin = json['pin'].toString();
    fav = json['fav'].toString();
    // if (json['reply'] != null) {
    //   reply = <Null>[];
    //   json['reply'].forEach((v) {
    //     reply!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['story'] != null) {
    //   story = <Null>[];
    //   json['story'].forEach((v) {
    //     story!.add(new Null.fromJson(v));
    //   });
    // }
    reaction = json['reaction'] != null
        ? new Reaction.fromJson(json['reaction'])
        : null;
    timeText = json['time_text'].toString();
    position = json['position'].toString();
    type = json['type'].toString();
    //product = json['product'];
    fileSize = json['file_size'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from_id'] = this.fromId;
    data['group_id'] = this.groupId;
    data['page_id'] = this.pageId;
    data['to_id'] = this.toId;
    data['text'] = this.text;
    data['media'] = this.media;
    data['mediaFileName'] = this.mediaFileName;
    data['mediaFileNames'] = this.mediaFileNames;
    data['time'] = this.time;
    data['seen'] = this.seen;
    data['deleted_one'] = this.deletedOne;
    data['deleted_two'] = this.deletedTwo;
    data['sent_push'] = this.sentPush;
    data['notification_id'] = this.notificationId;
    data['type_two'] = this.typeTwo;
    data['stickers'] = this.stickers;
    data['product_id'] = this.productId;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['reply_id'] = this.replyId;
    data['story_id'] = this.storyId;
    data['broadcast_id'] = this.broadcastId;
    data['forward'] = this.forward;
    data['listening'] = this.listening;
    data['delivered'] = this.delivered;
    if (this.messageUser != null) {
      data['messageUser'] = this.messageUser!.toJson();
    }
    data['pin'] = this.pin;
    data['fav'] = this.fav;
    // if (this.reply != null) {
    //   data['reply'] = this.reply!.map((v) => v.toJson()).toList();
    // }
    // if (this.story != null) {
    //   data['story'] = this.story!.map((v) => v.toJson()).toList();
    // }
    if (this.reaction != null) {
      data['reaction'] = this.reaction!.toJson();
    }
    data['time_text'] = this.timeText;
    data['position'] = this.position;
    data['type'] = this.type;
    data['product'] = this.product;
    data['file_size'] = this.fileSize;
    return data;
  }
}

class MessageUser {
  String? userId;
  String? avatar;

  MessageUser({this.userId, this.avatar});

  MessageUser.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'].toString();
    avatar = json['avatar'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['avatar'] = this.avatar;
    return data;
  }
}

class Reaction {
  bool? isReacted;
  String? type;
  String? count;
  String? i1;

  Reaction({this.isReacted, this.type, this.count, this.i1});

  Reaction.fromJson(Map<String, dynamic> json) {
    isReacted = json['is_reacted'];
    type = json['type'].toString();
    count = json['count'].toString();
    i1 = json['1'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_reacted'] = this.isReacted;
    data['type'] = this.type;
    data['count'] = this.count;
    data['1'] = this.i1;
    return data;
  }
}
