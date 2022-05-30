class SearchUserModel {
  List<Friends>? friends;
  int? total;

  SearchUserModel({this.friends, this.total});

  SearchUserModel.fromJson(Map<String, dynamic> json) {
    if (json['friends'] != null) {
      friends = <Friends>[];
      json['friends'].forEach((v) {
        friends!.add(new Friends.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.friends != null) {
      data['friends'] = this.friends!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class Friends {
  int? userId;
  String? firstName;
  String? lastName;
  String? userEmail;
  String? userAddress;
  String? userMobile;
  int? userStatus;
  String? userGender;
  String? profilePictureUrl;

  Friends(
      {this.userId,
        this.firstName,
        this.lastName,
        this.userEmail,
        this.userAddress,
        this.userMobile,
        this.userStatus,
        this.userGender,
        this.profilePictureUrl});

  Friends.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userEmail = json['userEmail'];
    userAddress = json['userAddress'];
    userMobile = json['userMobile'];
    userStatus = json['userStatus'];
    userGender = json['userGender'];
    profilePictureUrl = json['profilePictureUrl'];
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
    return data;
  }
}
