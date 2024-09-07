class ServiceHistoryModelHdr {
  int? id;
  List<dynamic>? customerId;
  String? mobile;
  String? problem;
  bool? delivered;
  String? state;
  String? createDate;

  ServiceHistoryModelHdr(
      {this.id,
      this.customerId,
      this.mobile,
      this.problem,
      this.delivered,
      this.state,
      this.createDate});

  ServiceHistoryModelHdr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    mobile = json['mobile'];
    problem = json['problem'];
    delivered = json['delivered'];
    state = json['state'];
    createDate = json['create_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['customer_id'] = customerId;
    data['mobile'] = mobile;
    data['problem'] = problem;
    data['delivered'] = delivered;
    data['state'] = state;
    data['create_date'] = createDate;
    return data;
  }
}
