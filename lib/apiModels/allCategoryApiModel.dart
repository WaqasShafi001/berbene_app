class CategoryApiModel {
  bool? success;
  int? status;
  List<CategoryResponse>? response;

  CategoryApiModel({this.success, this.status, this.response});

  CategoryApiModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    if (json['response'] != null) {
      response = <CategoryResponse>[];
      json['response'].forEach((v) {
        response!.add(new CategoryResponse.fromJson(v));
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

class CategoryResponse {
  int? i0;
  int? id;
  Null? parentId;
  String? title;
  String? titleAr;
  String? thumbnail;
  String? image;
  String? language;
  int? translationId;
  int? order;
  List<Subcategory>? subcategory;
  List<Products>? products;
  String? createdAt;
  String? updatedAt;

  CategoryResponse(
      {this.i0,
      this.id,
      this.parentId,
      this.title,
      this.titleAr,
      this.thumbnail,
      this.image,
      this.language,
      this.translationId,
      this.order,
      this.subcategory,
      this.products,
      this.createdAt,
      this.updatedAt});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    i0 = json['0'];
    id = json['id'];
    parentId = json['parentId'];
    title = json['title']??'';
    titleAr = json['title_ar']??'';
    thumbnail = json['thumbnail']??'';
    image = json['image']??'';
    language = json['language']??'';
    translationId = json['translationId'];
    order = json['order'];
    if (json['subcategory'] != null) {
      subcategory = <Subcategory>[];
      json['subcategory'].forEach((v) {
        subcategory!.add(new Subcategory.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['0'] = this.i0;
    data['id'] = this.id;
    data['parentId'] = this.parentId;
    data['title'] = this.title;
    data['title_ar'] = this.titleAr;
    data['thumbnail'] = this.thumbnail;
    data['image'] = this.image;
    data['language'] = this.language;
    data['translationId'] = this.translationId;
    data['order'] = this.order;
    if (this.subcategory != null) {
      data['subcategory'] = this.subcategory!.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Subcategory {
  int? i0;
  int? id;
  int? parentId;
  String? title;
  String? titleAr;
  String? thumbnail;
  String? image;
  String? language;
  int? translationId;
  int? order;
  List<Null>? subcategory;
  List<Products>? products;
  String? createdAt;
  String? updatedAt;

  Subcategory(
      {this.i0,
      this.id,
      this.parentId,
      this.title,
      this.titleAr,
      this.thumbnail,
      this.image,
      this.language,
      this.translationId,
      this.order,
      this.subcategory,
      this.products,
      this.createdAt,
      this.updatedAt});

  Subcategory.fromJson(Map<String, dynamic> json) {
    i0 = json['0'];
    id = json['id'];
    parentId = json['parentId'];
    title = json['title']??'';
    titleAr = json['title_ar']??'';
    thumbnail = json['thumbnail']??'';
    image = json['image']??'';
    language = json['language']??'';
    translationId = json['translationId'];
    order = json['order'];
    // if (json['subcategory'] != null) {
    //   subcategory = <Null>[];
    //   json['subcategory'].forEach((v) {
    //     subcategory!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['0'] = this.i0;
    data['id'] = this.id;
    data['parentId'] = this.parentId;
    data['title'] = this.title;
    data['title_ar'] = this.titleAr;
    data['thumbnail'] = this.thumbnail;
    data['image'] = this.image;
    data['language'] = this.language;
    data['translationId'] = this.translationId;
    data['order'] = this.order;
    // if (this.subcategory != null) {
    //   data['subcategory'] = this.subcategory!.map((v) => v.toJson()).toList();
    // }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Products {
  int? i0;
  int? id;
  int? categoryId;
  String? title;
  String? titleAr;
  String? thumbnail;
  String? image;
  int? price;
  int? chilli;
  int? halal;
  int? popular;
  int? vageterian;
  int? isFeatured;
  String? nutritionInfo;
  String? ingredients;
  int? translationId;
  String? nutritionInfoAr;
  String? ingredientsAr;
  String? language;
  int? order;
  List<Images>? images;
  String? createdAt;
  String? updatedAt;

  Products(
      {this.i0,
      this.id,
      this.categoryId,
      this.title,
      this.titleAr,
      this.thumbnail,
      this.image,
      this.price,
      this.chilli,
      this.halal,
      this.popular,
      this.vageterian,
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

  Products.fromJson(Map<String, dynamic> json) {
    i0 = json['0'];
    id = json['id'];
    categoryId = json['categoryId'];
    title = json['title']??'';
    titleAr = json['title_ar']??'';
    thumbnail = json['thumbnail']??'';
    image = json['image']??'';
    price = json['price']??'';
    chilli = json['chilli'];
    halal = json['halal'];
    popular = json['popular'];
    vageterian = json['vageterian'];
    isFeatured = json['isFeatured'];
    nutritionInfo = json['nutritionInfo']??'';
    ingredients = json['ingredients']??'';
    translationId = json['translationId'];
    nutritionInfoAr = json['nutritionInfo_ar']??'';
    ingredientsAr = json['ingredients_ar']??'';
    language = json['language']??'';
    order = json['order'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
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
    data['chilli'] = this.chilli;
    data['halal'] = this.halal;
    data['popular'] = this.popular;
    data['vageterian'] = this.vageterian;
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

class Images {
  int? i0;
  int? id;
  int? productId;
  int? cover;
  String? url;
  String? createdAt;
  String? updatedAt;

  Images(
      {this.i0,
      this.id,
      this.productId,
      this.cover,
      this.url,
      this.createdAt,
      this.updatedAt});

  Images.fromJson(Map<String, dynamic> json) {
    i0 = json['0'];
    id = json['id'];
    productId = json['product_id'];
    cover = json['cover'];
    url = json['url']??'';
    createdAt = json['created_at']??'';
    updatedAt = json['updated_at']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['0'] = this.i0;
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['cover'] = this.cover;
    data['url'] = this.url;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
