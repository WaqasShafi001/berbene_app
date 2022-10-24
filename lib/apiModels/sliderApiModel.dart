// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

class SliderAPIModel {
  bool? success;
  int? status;
  List<ResponseObject>? response;

  SliderAPIModel({this.success, this.status, this.response});

  SliderAPIModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    if (json['response'] != null) {
      response = <ResponseObject>[];
      json['response'].forEach((v) {
        response!.add(new ResponseObject.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResponseObject {
  int? id;
  String? title;
  String? image;

  ResponseObject({this.id, this.title, this.image});

  ResponseObject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    return data;
  }
}
