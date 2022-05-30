class UpcomingMessageModel {
  GroupData? groupData;
  int? senderId;

  UpcomingMessageModel({this.groupData, this.senderId});

  UpcomingMessageModel.fromJson(Map<String, dynamic> json) {
    groupData = json['groupData'] != null
        ? new GroupData.fromJson(json['groupData'])
        : null;
    senderId = json['senderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.groupData != null) {
      data['groupData'] = this.groupData!.toJson();
    }
    data['senderId'] = this.senderId;
    return data;
  }
}

class GroupData {
  int? groupId;
  List<String>? groupImage;
  String? groupName;
  String? lastActive;
  int? groupType;
  int? block;
  int? meBlocker;
  bool? meCreator;
  int? mute;
  List<Members>? members;
  String? recentMessage;
  String? mainRecentMessage;
  int? senderId;
  String? messageType;
  int? pendingMessage;

  GroupData(
      {this.groupId,
        this.groupImage,
        this.groupName,
        this.lastActive,
        this.groupType,
        this.block,
        this.meBlocker,
        this.meCreator,
        this.mute,
        this.members,
        this.recentMessage,
        this.mainRecentMessage,
        this.senderId,
        this.messageType,
        this.pendingMessage});

  GroupData.fromJson(Map<String, dynamic> json) {
    groupId = json['groupId'];
    groupImage = json['groupImage'].cast<String>();
    groupName = json['groupName'];
    lastActive = json['lastActive'];
    groupType = json['groupType'];
    block = json['block'];
    meBlocker = json['meBlocker'];
    meCreator = json['meCreator'];
    mute = json['mute'];
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(new Members.fromJson(v));
      });
    }
    recentMessage = json['recentMessage'];
    mainRecentMessage = json['mainRecentMessage'];
    senderId = json['senderId'];
    messageType = json['messageType'];
    pendingMessage = json['pendingMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupId'] = this.groupId;
    data['groupImage'] = this.groupImage;
    data['groupName'] = this.groupName;
    data['lastActive'] = this.lastActive;
    data['groupType'] = this.groupType;
    data['block'] = this.block;
    data['meBlocker'] = this.meBlocker;
    data['meCreator'] = this.meCreator;
    data['mute'] = this.mute;
    if (this.members != null) {
      data['members'] = this.members!.map((v) => v.toJson()).toList();
    }
    data['recentMessage'] = this.recentMessage;
    data['mainRecentMessage'] = this.mainRecentMessage;
    data['senderId'] = this.senderId;
    data['messageType'] = this.messageType;
    data['pendingMessage'] = this.pendingMessage;
    return data;
  }
}

class Members {
  int? userId;
  String? firstName;
  String? lastName;
  String? userEmail;
  Null? userAddress;
  Null? userMobile;
  int? userStatus;
  Null? userGender;
  String? profilePictureUrl;
  int? active;

  Members(
      {this.userId,
        this.firstName,
        this.lastName,
        this.userEmail,
        this.userAddress,
        this.userMobile,
        this.userStatus,
        this.userGender,
        this.profilePictureUrl,
        this.active});

  Members.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userEmail = json['userEmail'];
    //userAddress = json['userAddress'];
    //userMobile = json['userMobile'];
    userStatus = json['userStatus'];
    //userGender = json['userGender'];
    profilePictureUrl = json['profilePictureUrl'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
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
