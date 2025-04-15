class CustomersListModel {
  int? pk;
  String? sectorId;
  String? name;
  bool? isMain;
  String? address;
  String? phone;
  String? createdDate;

  CustomersListModel(
      {this.pk,
      this.sectorId,
      this.name,
      this.isMain,
      this.address,
      this.phone,
      this.createdDate});

  CustomersListModel.fromJson(Map<String, dynamic> json) {
    pk = json['pk'];
    sectorId = json['sectorId'];
    name = json['name'];
    isMain = json['isMain'];
    address = json['address'];
    phone = json['phone'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pk'] = this.pk;
    data['sectorId'] = this.sectorId;
    data['name'] = this.name;
    data['isMain'] = this.isMain;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['createdDate'] = this.createdDate;
    return data;
  }
}
