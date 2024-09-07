// ignore_for_file: unnecessary_this, prefer_collection_literals, unnecessary_new

class PaymentList {
  int? id;
  String? name;

  PaymentList({this.id, this.name});

  PaymentList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
