class ProductSold {
  int? userPk;
  int? infoOutSector;
  int? infoToSector;
  double? totalPrice;
  String? description;
  bool? isIncome;
  List<HistoryProducts>? historyProducts;

  ProductSold(
      {this.userPk,
      this.infoOutSector,
      this.infoToSector,
      this.totalPrice,
      this.description,
      this.isIncome,
      this.historyProducts});

  ProductSold.fromJson(Map<String, dynamic> json) {
    userPk = json['UserPk'];
    infoOutSector = json['infoOutSector'];
    infoToSector = json['infoToSector'];
    totalPrice = json['totalPrice'];
    description = json['description'];
    isIncome = json['isIncome'];
    if (json['history_products'] != null) {
      historyProducts = <HistoryProducts>[];
      json['history_products'].forEach((v) {
        historyProducts!.add(new HistoryProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserPk'] = this.userPk;
    data['infoOutSector'] = this.infoOutSector;
    data['infoToSector'] = this.infoToSector;
    data['totalPrice'] = this.totalPrice;
    data['description'] = this.description;
    data['isIncome'] = this.isIncome;
    if (this.historyProducts != null) {
      data['history_products'] =
          this.historyProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HistoryProducts {
  int? product;
  double? quantity;

  HistoryProducts({this.product, this.quantity});

  HistoryProducts.fromJson(Map<String, dynamic> json) {
    product = json['product'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = this.product;
    data['quantity'] = this.quantity;
    return data;
  }
}
