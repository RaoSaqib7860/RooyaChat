class OneToOneChatModel {
  Sender? sender;
  Message? message;

  OneToOneChatModel({this.sender, this.message});

  OneToOneChatModel.fromJson(Map<String, dynamic> json) {
    print('sender = ${json['sender']}');
    print('message = ${json['message']}');
    sender =
        json['sender'] != null ? new Sender.fromJson(json['sender']) : null;
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class Sender {
  int? userId;
  String? firstName;
  String? lastName;
  String? userEmail;

  // Null userAddress;
  // Null userMobile;
  int? userStatus;

  // Null userGender;
  String? profilePictureUrl;

  Sender(
      {this.userId,
      this.firstName,
      this.lastName,
      this.userEmail,
      // this.userAddress,
      // this.userMobile,
      this.userStatus,
      // this.userGender,
      this.profilePictureUrl});

  Sender.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('userId')) {
      userId = json['userId'];
    } else {
      userId = -1;
    }
    if (json.containsKey('firstName')) {
      firstName = json['firstName'].toString();
    } else {
      firstName = '';
    }
    if (json.containsKey('lastName')) {
      lastName = json['lastName'].toString();
    } else {
      lastName = '';
    }
    if (json.containsKey('userEmail')) {
      userEmail = json['userEmail'].toString();
    } else {
      userEmail = '';
    }
    if (json.containsKey('userStatus')) {
      userStatus = json['userStatus'];
    } else {
      userStatus = 0;
    }
    if (json.containsKey('profilePictureUrl')) {
      profilePictureUrl = json['profilePictureUrl'].toString();
    } else {
      profilePictureUrl = '';
    }
    // userAddress = json['userAddress'];
    // userMobile = json['userMobile'];
    // userGender = json['userGender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['userEmail'] = this.userEmail;
    // data['userAddress'] = this.userAddress;
    // data['userMobile'] = this.userMobile;
    data['userStatus'] = this.userStatus;
    // data['userGender'] = this.userGender;
    data['profilePictureUrl'] = this.profilePictureUrl;
    return data;
  }
}

class Message {
  String? mId;
  String? sender;
  String? receiver;
  String? message;
  String? type;
  String? link;
  String? linkData;
  String? receiverType;
  String? date;
  String? time;
  String? dateTime;
  String? iosDateTime;

  Message(
      {this.mId,
      this.sender,
      this.receiver,
      this.message,
      this.type,
      this.link,
      this.linkData,
      this.receiverType,
      this.date,
      this.time,
      this.dateTime,
      this.iosDateTime});

  Message.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('m_id')) {
      mId = json['m_id'].toString();
    }
    if (json.containsKey('sender')) {
      sender = json['sender'].toString();
    }else{
      sender='';
    }
    if (json.containsKey('receiver')) {
      receiver = json['receiver'].toString();
    }
    if (json.containsKey('message')) {
      message = json['message'].toString();
    }
    if (json.containsKey('type')) {
      type = json['type'].toString();
    }
    if (json.containsKey('link')) {
      link = json['link'].toString();
    }
    if (json.containsKey('linkData')) {
      linkData = json['linkData'].toString();
    }
    if (json.containsKey('receiver_type')) {
      receiverType = json['receiver_type'].toString();
    }
    if (json.containsKey('date')) {
      date = json['date'].toString();
    }
    if (json.containsKey('time')) {
      time = json['time'].toString();
    }
    if (json.containsKey('date_time')) {
      dateTime = json['date_time'].toString();
    }
    if (json.containsKey('ios_date_time')) {
      iosDateTime = json['ios_date_time'].toString();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['m_id'] = this.mId;
    data['sender'] = this.sender;
    data['receiver'] = this.receiver;
    data['message'] = this.message;
    data['type'] = this.type;
    data['link'] = this.link;
    data['linkData'] = this.linkData;
    data['receiver_type'] = this.receiverType;
    data['date'] = this.date;
    data['time'] = this.time;
    data['date_time'] = this.dateTime;
    data['ios_date_time'] = this.iosDateTime;
    return data;
  }
}
