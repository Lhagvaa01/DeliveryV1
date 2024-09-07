// ignore_for_file: unnecessary_new, prefer_collection_literals

class RepairHistoryDtl {
  int? id;
  List<dynamic>? customerId;
  String? mobile;
  String? problem;
  bool? delivered;
  bool? note;
  String? state;
  String? createDate;
  List<Details>? details;

  RepairHistoryDtl(
      {this.id,
      this.customerId,
      this.mobile,
      this.problem,
      this.delivered,
      this.note,
      this.state,
      this.createDate,
      this.details});

  RepairHistoryDtl.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    mobile = json['mobile'];
    problem = json['problem'];
    delivered = json['delivered'];
    note = json['note'];
    state = json['state'];
    createDate = json['create_date'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['customer_id'] = customerId;
    data['mobile'] = mobile;
    data['problem'] = problem;
    data['delivered'] = delivered;
    data['note'] = note;
    data['state'] = state;
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
  List<String>? product;
  bool? note;
  bool? delivered;
  String? state;

  Details(
      {this.id,
      this.serialId,
      this.product,
      this.note,
      this.delivered,
      this.state});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serialId = json['serial_id'];
    product = json['product'].runtimeType != bool
        ? json['product'].cast<String>()
        : ["", ""];
    note = json['note'];
    delivered = json['delivered'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['serial_id'] = serialId;
    data['product'] = product;
    data['note'] = note;
    data['delivered'] = delivered;
    data['state'] = state;
    return data;
  }
}
