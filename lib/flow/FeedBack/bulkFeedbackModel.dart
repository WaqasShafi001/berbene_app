class BulkFeedback {
  String? deviceid;
  List<Map<String, dynamic>>? feedbacks;

  BulkFeedback({this.deviceid, this.feedbacks});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deviceid'] = this.deviceid;
    if (this.feedbacks != null) {
      data['feedbacks'] = this.feedbacks!;
    }
    return data;
  }
}

class Feedbackk {
  int? id;
  String? orderCode;
  int? foodTaste;
  int? environment;
  int? service;
  int? staffBehaviour;
  String? comment;
  String? phone;

  Feedbackk(
      {this.id,
      this.orderCode,
      this.foodTaste,
      this.environment,
      this.service,
      this.staffBehaviour,
      this.comment,
      this.phone});

  Feedbackk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderCode = json['order_code'];
    foodTaste = json['food_taste'];
    environment = json['environment'];
    service = json['service'];
    staffBehaviour = json['staff_behaviour'];
    comment = json['comment'];
    phone = json['phone'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderCode': orderCode,
      'foodTaste': foodTaste,
      'environment': environment,
      'service': service,
      'staffBehaviour': staffBehaviour,
      'comment': comment,
      'phone': phone,
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_code'] = this.orderCode;
    data['food_taste'] = this.foodTaste;
    data['environment'] = this.environment;
    data['service'] = this.service;
    data['staff_behaviour'] = this.staffBehaviour;
    data['comment'] = this.comment;
    data['phone'] = this.phone;
    return data;
  }
}
