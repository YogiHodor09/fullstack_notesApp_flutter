class LoginModel {
  String? data;
  bool? success;

  LoginModel({this.data, this.success});

  LoginModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['data'] = this.data;
    data['success'] = this.success;
    return data;
  }
}
