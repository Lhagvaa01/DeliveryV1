class ProductListModel {
  int? id;
  String? name;
  String? accountCode;
  String? note;
  String? createDate;
  String? writeDate;

  ProductListModel(
      {this.id,
      this.name,
      this.accountCode,
      this.note,
      this.createDate,
      this.writeDate});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'].toString();
    accountCode = json['account_code'].toString();
    note = json['note'].toString();
    createDate = json['create_date'].toString();
    writeDate = json['write_date'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['account_code'] = accountCode;
    data['note'] = note;
    data['create_date'] = createDate;
    data['write_date'] = writeDate;
    return data;
  }
}
