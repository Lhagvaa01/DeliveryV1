class ProductListModel {
  int? pk;
  String? itemCode;
  String? itemName;
  String? itemBillName;
  String? itemPrice;
  bool? isActive;
  String? createdDate;

  ProductListModel(
      {this.pk,
      this.itemCode,
      this.itemName,
      this.itemBillName,
      this.itemPrice,
      this.isActive,
      this.createdDate});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    pk = json['pk'];
    itemCode = json['itemCode'];
    itemName = json['itemName'];
    itemBillName = json['itemBillName'];
    itemPrice = json['itemPrice'];
    isActive = json['isActive'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pk'] = this.pk;
    data['itemCode'] = this.itemCode;
    data['itemName'] = this.itemName;
    data['itemBillName'] = this.itemBillName;
    data['itemPrice'] = this.itemPrice;
    data['isActive'] = this.isActive;
    data['createdDate'] = this.createdDate;
    return data;
  }
}
