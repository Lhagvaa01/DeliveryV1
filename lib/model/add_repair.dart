class AddRepair {
  int? customerId;
  String? mobile;
  String? problem;
  List<dynamic>? details;

  AddRepair({this.customerId, this.mobile, this.problem, this.details});

  AddRepair.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    mobile = json['mobile'];
    problem = json['problem'];
    details = json['details'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = customerId;
    data['mobile'] = mobile;
    data['problem'] = problem;
    data['details'] = details;
    return data;
  }
}
