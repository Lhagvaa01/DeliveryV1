// ignore_for_file: prefer_collection_literals, unrelated_type_equality_checks

class SalesHistoryDtl {
  int? id;
  List<dynamic>? customerId;
  List<dynamic>? paymentId;
  String? delivered;
  dynamic note;
  String? createDate;
  List<Details>? details;

  SalesHistoryDtl(
      {this.id,
      this.customerId,
      this.paymentId,
      this.delivered,
      this.note,
      this.createDate,
      this.details});

  SalesHistoryDtl.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    paymentId = json['payment_id'];
    delivered = json['delivered'];
    note = json['note'].toString();
    createDate = json['create_date'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['customer_id'] = customerId;
    data['payment_id'] = paymentId;
    data['delivered'] = delivered;
    data['note'] = note;
    data['create_date'] = createDate;
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  int? id;
  List<dynamic>? serialId;
  List<dynamic>? product;

  Details({this.id, this.serialId, this.product});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serialId = json['serial_id'];
    product = json['product'] == "false" ? product : ["", ""];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['serial_id'] = serialId;
    data['product'] = product;
    return data;
  }
}
//