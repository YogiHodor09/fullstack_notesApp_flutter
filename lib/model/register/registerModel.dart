class RegisterModel {
  String? data;
  bool? success;

  RegisterModel({this.data, this.success});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    data['success'] = this.success;
    return data;
  }
}
