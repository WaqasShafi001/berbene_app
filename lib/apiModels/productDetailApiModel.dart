class ProductDetailApiModel {
  bool? success;
  int? status;
  List<SingleProductResponse>? response;

  ProductDetailApiModel({this.success, this.status, this.response});

  ProductDetailApiModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    if (json['response'] != null) {
      response = <SingleProductResponse>[];
      json['response'].forEach((v) {
        response!.add(new SingleProductResponse.fromJson(v));
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

class SingleProductResponse {
  int? i0;
  int? id;
  int? categoryId;
  String? title;
  String? titleAr;
  String? thumbnail;
  String? image;
  int? price;
  int? isFeatured;
  String? nutritionInfo;
  String? ingredients;
  int? translationId;
  String? nutritionInfoAr;
  String? ingredientsAr;
  String? language;
  int? order;
  List<ProductSliderImages>? images;
  String? createdAt;
  String? updatedAt;

  SingleProductResponse(
      {this.i0,
      this.id,
      this.categoryId,
      this.title,
      this.titleAr,
      this.thumbnail,
      this.image,
      this.price,
      this.isFeatured,
      this.nutritionInfo,
      this.ingredients,
      this.translationId,
      this.nutritionInfoAr,
      this.ingredientsAr,
      this.language,
      this.order,
      this.images,
      this.createdAt,
      this.updatedAt});

  SingleProductResponse.fromJson(Map<String, dynamic> json) {
    i0 = json['0'];
    id = json['id'];
    categoryId = json['categoryId'];
    title = json['title'] ?? '....';
    titleAr = json['title_ar'] ?? '....';
    thumbnail = json['thumbnail'] ?? '';
    image = json['image'] ?? '';
    price = json['price'];
    isFeatured = json['isFeatured'];
    nutritionInfo = json['nutritionInfo'] ?? '....';
    ingredients = json['ingredients'] ?? '....';
    translationId = json['translationId'];
    nutritionInfoAr = json['nutritionInfo_ar'] ?? '....';
    ingredientsAr = json['ingredients_ar'] ?? '....';
    language = json['language'];
    order = json['order'];
    if (json['images'] != null) {
      images = <ProductSliderImages>[];
      json['images'].forEach((v) {
        images!.add(new ProductSliderImages.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['0'] = this.i0;
    data['id'] = this.id;
    data['categoryId'] = this.categoryId;
    data['title'] = this.title;
    data['title_ar'] = this.titleAr;
    data['thumbnail'] = this.thumbnail;
    data['image'] = this.image;
    data['price'] = this.price;
    data['isFeatured'] = this.isFeatured;
    data['nutritionInfo'] = this.nutritionInfo;
    data['ingredients'] = this.ingredients;
    data['translationId'] = this.translationId;
    data['nutritionInfo_ar'] = this.nutritionInfoAr;
    data['ingredients_ar'] = this.ingredientsAr;
    data['language'] = this.language;
    data['order'] = this.order;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ProductSliderImages {
  int? i0;
  int? id;
  int? productId;
  String? url;
  String? createdAt;
  String? updatedAt;

  ProductSliderImages(
      {this.i0,
      this.id,
      this.productId,
      this.url,
      this.createdAt,
      this.updatedAt});

  ProductSliderImages.fromJson(Map<String, dynamic> json) {
    i0 = json['0'];
    id = json['id'];
    productId = json['product_id'];
    url = json['url'] ?? '';
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['0'] = this.i0;
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['url'] = this.url;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
