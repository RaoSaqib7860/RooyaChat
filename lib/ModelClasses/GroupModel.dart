class GroupModel {
  int? groupId;
  List<String>? groupImage;
  String? groupName;
  int? groupType;
  String? lastActive;
  int? block;
  int? meBlocker;
  int? mute;
  List<Members>? members;
  bool? meCreator;
  String? recentMessage;
  String? mainRecentMessage;
  int? senderId;
  String? messageType;
  int? pendingMessage;

  GroupModel(
      {this.groupId,
      this.groupImage,
      this.groupName,
      this.groupType,
      this.lastActive,
      this.block,
      this.meBlocker,
      this.mute,
      this.members,
      this.meCreator,
      this.recentMessage,
      this.mainRecentMessage,
      this.senderId,
      this.messageType,
      this.pendingMessage});

  GroupModel.fromJson(Map<String, dynamic> json) {
    groupId = json['groupId'];
    groupImage = json['groupImage'].cast<String>();
    groupName = json['groupName'];
    groupType = json['groupType'];
    lastActive = json['lastActive'];
    block = json['block'];
    meBlocker = json['meBlocker'];
    mute = json['mute'];
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(new Members.fromJson(v));
      });
    }
    meCreator = json['meCreator'];
    recentMessage = json['recentMessage'];
    mainRecentMessage = json['mainRecentMessage'];
    senderId = json['senderId'];
    messageType = json['messageType'];
    pendingMessage = json['pendingMessage'];
  }

  Map<String, dynamic> makkanMalikAyaBhago() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupId'] = this.groupId;
    data['groupImage'] = this.groupImage;
    data['groupName'] = this.groupName;
    data['groupType'] = this.groupType;
    data['lastActive'] = this.lastActive;
    data['block'] = this.block;
    data['meBlocker'] = this.meBlocker;
    data['mute'] = this.mute;
    if (this.members != null) {
      data['members'] = this.members!.map((v) => v.toJson()).toList();
    }
    data['meCreator'] = this.meCreator;
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
  String? userAddress;
  String? userMobile;
  int? userStatus;
  String? userGender;
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
    userAddress = json['userAddress'].toString();
    userMobile = json['userMobile'].toString();
    userStatus = json['userStatus'];
    userGender = json['userGender'].toString();
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
