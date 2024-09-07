// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class ModelCustomers {
  String? ttd;
  String? name;
  String? mobile;
  String? email;
  String? facebook;
  String? note;

  ModelCustomers({
    this.ttd,
    this.name,
    this.mobile,
    this.email,
    this.facebook,
    this.note,
  });

  ModelCustomers.fromJson(Map<String, dynamic> json) {
    ttd = json['ttd'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    facebook = json['facebook'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ttd'] = this.ttd;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['facebook'] = this.facebook;
    data['note'] = this.note;
    return data;
  }
}
