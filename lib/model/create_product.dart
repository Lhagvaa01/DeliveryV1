class ModelProduct {
  int? productId;
  List<String>? serials;

  ModelProduct({this.productId, this.serials});

  ModelProduct.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    serials = json['serials'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = productId;
    data['serials'] = serials;
    return data;
  }
}
