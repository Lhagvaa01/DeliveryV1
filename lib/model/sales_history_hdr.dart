class SalesHistoryHdr {
  int? id;
  List<dynamic>? customerId;
  List<dynamic>? paymentId;
  String? delivered;
  String? createDate;

  SalesHistoryHdr(
      {this.id,
      this.customerId,
      this.paymentId,
      this.delivered,
      this.createDate});

  SalesHistoryHdr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    paymentId = json['payment_id'];
    delivered = json['delivered'];
    createDate = json['create_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['customer_id'] = customerId;
    data['payment_id'] = paymentId;
    data['delivered'] = delivered;
    data['create_date'] = createDate;
    return data;
  }
}
