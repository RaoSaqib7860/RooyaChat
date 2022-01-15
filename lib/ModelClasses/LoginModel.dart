class LoginModel {
  Status? status;
  String? response;
  String? type;

  LoginModel({this.status, this.response, this.type});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    response = json['response'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    data['response'] = this.response;
    data['type'] = this.type;
    return data;
  }
}

class Status {
  int? code;
  String? message;

  Status({this.code, this.message});

  Status.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}
