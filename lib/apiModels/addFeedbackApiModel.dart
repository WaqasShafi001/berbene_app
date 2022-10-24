class FeedBackApiModel {
  bool? success;
  int? status;
  String? message;

  FeedBackApiModel({this.success, this.status, this.message});

  FeedBackApiModel.fromJson(Map<String, dynamic> json) {
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
