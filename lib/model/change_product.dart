class ChangeProduct {
  int? cinfoId;
  int? productId;
  String? changeId;
  String? note;
  String? state;

  ChangeProduct(
      {this.cinfoId, this.productId, this.changeId, this.note, this.state});

  ChangeProduct.fromJson(Map<String, dynamic> json) {
    cinfoId = json['cinfo_id'];
    productId = json['product_id'];
    changeId = json['change_id'];
    note = json['note'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cinfo_id'] = cinfoId;
    data['product_id'] = productId;
    data['change_id'] = changeId;
    data['note'] = note;
    data['state'] = state;
    return data;
  }
}
