class BulkFeedbackModel {
  bool? success;
  int? status;
  String? message;

  BulkFeedbackModel({this.success, this.status, this.message});

  BulkFeedbackModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
