class LoginModel {
  int? apiStatus;
  String? timezone;
  String? accessToken;
  String? userId;
  bool? membership;

  LoginModel(
      {this.apiStatus,
        this.timezone,
        this.accessToken,
        this.userId,
        this.membership});

  LoginModel.fromJson(Map<String, dynamic> json) {
    apiStatus = json['api_status'];
    timezone = json['timezone'];
    accessToken = json['access_token'];
    userId = json['user_id'];
    membership = json['membership'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_status'] = this.apiStatus;
    data['timezone'] = this.timezone;
    data['access_token'] = this.accessToken;
    data['user_id'] = this.userId;
    data['membership'] = this.membership;
    return data;
  }
}
