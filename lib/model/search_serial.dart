// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class SearchSerial {
  int? id;
  String? serial;
  List<dynamic>? productId;
  String? state;
  String? createDate;
  String? writeDate;

  SearchSerial(
      {this.id,
      this.serial,
      this.productId,
      this.state,
      this.createDate,
      this.writeDate});

  SearchSerial.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serial = json['serial'];
    productId = json['product_id'];
    state = json['state'];
    createDate = json['create_date'];
    writeDate = json['write_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serial'] = this.serial;
    data['product_id'] = this.productId;
    data['state'] = this.state;
    data['create_date'] = this.createDate;
    data['write_date'] = this.writeDate;
    return data;
  }
}
