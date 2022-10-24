class ImagesAll {
  bool? success;
  int? status;
  List<String>? data;

  ImagesAll({this.success, this.status, this.data});

  ImagesAll.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['data'] = this.data;
    return data;
  }
}
