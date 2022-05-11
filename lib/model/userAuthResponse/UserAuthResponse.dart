class UserAuthResponse {
  String? userData;
  bool? success;

  UserAuthResponse({this.userData, this.success});

  UserAuthResponse.fromJson(Map<String, dynamic> json) {
    userData = json['userData'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userData'] = this.userData;
    data['success'] = this.success;
    return data;
  }
}
