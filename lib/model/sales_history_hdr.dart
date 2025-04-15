class SalesHistoryHdr {
  int? pk;
  String? userPk;
  String? infoOutSector;
  String? infoToSector;
  String? totalPrice;
  String? description;
  bool? isIncome;
  String? createdDate;
  List<HistoryProducts>? historyProducts;

  SalesHistoryHdr(
      {this.pk,
      this.userPk,
      this.infoOutSector,
      this.infoToSector,
      this.totalPrice,
      this.description,
      this.isIncome,
      this.createdDate,
      this.historyProducts});

  SalesHistoryHdr.fromJson(Map<String, dynamic> json) {
    pk = json['pk'];
    userPk = json['UserPk'];
    infoOutSector = json['infoOutSector'];
    infoToSector = json['infoToSector'];
    totalPrice = json['totalPrice'];
    description = json['description'];
    isIncome = json['isIncome'];
    createdDate = json['createdDate'];
    if (json['history_products'] != null) {
      historyProducts = <HistoryProducts>[];
      json['history_products'].forEach((v) {
        historyProducts!.add(new HistoryProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pk'] = this.pk;
    data['UserPk'] = this.userPk;
    data['infoOutSector'] = this.infoOutSector;
    data['infoToSector'] = this.infoToSector;
    data['totalPrice'] = this.totalPrice;
    data['description'] = this.description;
    data['isIncome'] = this.isIncome;
    data['createdDate'] = this.createdDate;
    if (this.historyProducts != null) {
      data['history_products'] =
          this.historyProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HistoryProducts {
  int? pk;
  Product? product;
  String? quantity;

  HistoryProducts({this.pk, this.product, this.quantity});

  HistoryProducts.fromJson(Map<String, dynamic> json) {
    pk = json['pk'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pk'] = this.pk;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['quantity'] = this.quantity;
    return data;
  }
}

class Product {
  int? pk;
  String? itemCode;
  String? itemName;
  String? itemBillName;
  String? itemPrice;
  bool? isActive;
  String? createdDate;

  Product(
      {this.pk,
      this.itemCode,
      this.itemName,
      this.itemBillName,
      this.itemPrice,
      this.isActive,
      this.createdDate});

  Product.fromJson(Map<String, dynamic> json) {
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
