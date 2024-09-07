// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals
class LoginInfo {
  String? status;
  String? authToken;
  String? surname;
  String? name;
  String? email;
  String? phone;

  LoginInfo(
      {this.status,
      this.authToken,
      this.surname,
      this.name,
      this.email,
      this.phone});

  LoginInfo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    authToken = json['auth_token'];
    surname = json['surname'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['auth_token'] = this.authToken;
    data['surname'] = this.surname;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}
