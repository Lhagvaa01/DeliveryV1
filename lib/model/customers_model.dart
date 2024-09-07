class CustomersListModel {
  int? id;
  String? ttd;
  String? name;
  String? mobile;
  String? email;
  String? facebook;
  String? createDate;
  String? writeDate;

  CustomersListModel(
      {this.id,
      this.ttd,
      this.name,
      this.mobile,
      this.email,
      this.facebook,
      this.createDate,
      this.writeDate});

  CustomersListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ttd = json['ttd'].toString();
    name = json['name'].toString();
    mobile = json['mobile'].toString();
    email = json['email'].toString();
    facebook = json['facebook'].toString();
    createDate = json['create_date'];
    writeDate = json['write_date'];
  }
}
