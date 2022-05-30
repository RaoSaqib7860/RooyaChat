class OneToOneChatModel {
  Sender? sender;
  Message? message;
  Send? send;
  Seen? seen;
  Delivery? delivery;
  Oldmessage? oldmessage;

  OneToOneChatModel(
      {this.sender, this.message, this.send, this.seen, this.delivery});

  OneToOneChatModel.fromJson(Map<String, dynamic> json) {
    sender =
    json['sender'] != null ? new Sender.fromJson(json['sender']) : null;
    message =
    json['message'] != null ? new Message.fromJson(json['message']) : null;
    send = json['send'] != null ? new Send.fromJson(json['send']) : null;
    seen = json['seen'] != null ? new Seen.fromJson(json['seen']) : null;
    delivery = json['delivery'] != null
        ? new Delivery.fromJson(json['delivery'])
        : null;
    oldmessage = json['oldmessage'] != null
        ? new Oldmessage.fromJson(json['oldmessage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    if (this.send != null) {
      data['send'] = this.send!.toJson();
    }
    if (this.seen != null) {
      data['seen'] = this.seen!.toJson();
    }
    if (this.delivery != null) {
      data['delivery'] = this.delivery!.toJson();
    }
    return data;
  }
}

class Sender {
  int? userId;
  bool? isadmin;
  String? firstName;
  String? lastName;
  String? userEmail;
  String? userAddress;
  String? userMobile;
  int? userStatus;
  String? userGender;
  String? profilePictureUrl;
  int? active;

  Sender(
      {this.userId,
        this.isadmin,
        this.firstName,
        this.lastName,
        this.userEmail,
        this.userAddress,
        this.userMobile,
        this.userStatus,
        this.userGender,
        this.profilePictureUrl,
        this.active});

  Sender.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    isadmin = json['isadmin'];
    firstName = json['firstName'].toString();
    lastName = json['lastName'].toString();
    userEmail = json['userEmail'].toString();
    userAddress = json['userAddress'].toString();
    userMobile = json['userMobile'].toString();
    userStatus = json['userStatus'];
    userGender = json['userGender'].toString();
    profilePictureUrl = json['profilePictureUrl'].toString();
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['isadmin'] = this.isadmin;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['userEmail'] = this.userEmail;
    data['userAddress'] = this.userAddress;
    data['userMobile'] = this.userMobile;
    data['userStatus'] = this.userStatus;
    data['userGender'] = this.userGender;
    data['profilePictureUrl'] = this.profilePictureUrl;
    data['active'] = this.active;
    return data;
  }
}

class Message {
  String? mId;
  String? sender;
  String? receiver;
  String? message;
  int? onlyemoji;
  String? type;
  String? fileName;
  String? link;
  String? linkData;
  String? receiverType;
  String? date;
  String? time;
  String? dateTime;
  String? replyMsgId;
  String? isDeleted;
  String? removeBy;
  String? poster;
  String? iosDateTime;

  Message(
      {this.mId,
        this.sender,
        this.receiver,
        this.message,
        this.onlyemoji,
        this.type,
        this.fileName,
        this.link,
        this.linkData,
        this.receiverType,
        this.date,
        this.time,
        this.dateTime,
        this.replyMsgId,
        this.isDeleted,
        this.removeBy,
        this.poster,
        this.iosDateTime});

  Message.fromJson(Map<String, dynamic> json) {
    mId = json['m_id'].toString();
    sender = json['sender'].toString();
    receiver = json['receiver'].toString();
    message = json['message'].toString();
    onlyemoji = json['onlyemoji'];
    type = json['type'].toString();
    fileName = json['fileName'].toString();
    link = json['link'].toString();
    linkData = json['linkData'].toString();
    receiverType = json['receiver_type'].toString();
    date = json['date'].toString();
    time = json['time'].toString();
    dateTime = json['date_time'].toString();
    replyMsgId = json['reply_msg_id'].toString();
    isDeleted = json['is_deleted'].toString();
    removeBy = json['remove_by'].toString();
    poster = json['poster'].toString();
    iosDateTime = json['ios_date_time'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['m_id'] = this.mId;
    data['sender'] = this.sender;
    data['receiver'] = this.receiver;
    data['message'] = this.message;
    data['onlyemoji'] = this.onlyemoji;
    data['type'] = this.type;
    data['fileName'] = this.fileName;
    data['link'] = this.link;
    data['linkData'] = this.linkData;
    data['receiver_type'] = this.receiverType;
    data['date'] = this.date;
    data['time'] = this.time;
    data['date_time'] = this.dateTime;
    data['reply_msg_id'] = this.replyMsgId;
    data['is_deleted'] = this.isDeleted;
    data['remove_by'] = this.removeBy;
    data['poster'] = this.poster;
    data['ios_date_time'] = this.iosDateTime;
    return data;
  }
}

class Send {
  String? send;
  String? time;

  Send({this.send, this.time});

  Send.fromJson(Map<String, dynamic> json) {
    send = json['send'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['send'] = this.send;
    data['time'] = this.time;
    return data;
  }
}

class Seen {
  String? seen;
  String? time;

  Seen({this.seen, this.time});

  Seen.fromJson(Map<String, dynamic> json) {
    seen = json['seen'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seen'] = this.seen;
    data['time'] = this.time;
    return data;
  }
}

class Delivery {
  String? devliver;
  String? time;

  Delivery({this.devliver, this.time});

  Delivery.fromJson(Map<String, dynamic> json) {
    devliver = json['devliver'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['devliver'] = this.devliver;
    data['time'] = this.time;
    return data;
  }
}
class Oldmessage {
  String? oSender;
  String? oSenderName;
  String? oMessage;
  String? oType;

  Oldmessage({this.oSender, this.oSenderName, this.oMessage, this.oType});

  Oldmessage.fromJson(Map<String, dynamic> json) {
    oSender = json['o_sender'];
    oSenderName = json['o_sender_name'];
    oMessage = json['o_message'];
    oType = json['o_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['o_sender'] = this.oSender;
    data['o_sender_name'] = this.oSenderName;
    data['o_message'] = this.oMessage;
    data['o_type'] = this.oType;
    return data;
  }
}
