// ignore_for_file: unnecessary_this

class ProductSold {
  int? customerId;
  int? paymentId;
  String? delivered;
  String? note;
  List<int>? details;

  ProductSold(
      {this.customerId,
      this.paymentId,
      this.delivered,
      this.note,
      this.details});

  ProductSold.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    paymentId = json['payment_id'];
    delivered = json['delivered'];
    note = json['note'];
    details = json['details'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['payment_id'] = this.paymentId;
    data['delivered'] = this.delivered;
    data['note'] = this.note;
    data['details'] = this.details;
    return data;
  }
}
