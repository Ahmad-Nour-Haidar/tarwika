import 'dart:convert';

import 'package:tarwika/model/cart_model.dart';

class ItemModel {
  int? id;
  int? categoryId;
  String? name;
  String? nameAr;
  String? description;
  String? descriptionAr;
  Price? price;
  String? image;
  bool? isFavorite;
  String? categoryName;

  ItemModel(
      {this.id,
      this.categoryId,
      this.name,
      this.nameAr,
      this.description,
      this.descriptionAr,
      this.price,
      this.image,
      this.isFavorite,
      this.categoryName});

  ItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    nameAr = json['name_ar'];
    description = json['description'];
    descriptionAr = json['description_ar'];
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
    image = json['image'];
    isFavorite = json['is_favorite'];
    categoryName = json['category_name'];
  }

  ItemModel.fromCartModel(CartModel model) {
    id = model.itemId;
    categoryId = model.categoryId;
    name = model.name;
    nameAr = model.nameAr;
    description = model.description;
    descriptionAr = model.descriptionAr;
    price = Price.fromJson(jsonDecode(model.price.toString()));
    image = model.image;
    isFavorite = true;
    categoryName = model.categoryName;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['name'] = name;
    data['name_ar'] = nameAr;
    data['description'] = description;
    data['description_ar'] = descriptionAr;
    if (price != null) {
      data['price'] = price!.toJson();
    }
    data['image'] = image;
    data['is_favorite'] = isFavorite;
    data['category_name'] = categoryName;
    return data;
  }

  @override
  String toString() {
    return 'ItemModel{id: $id, categoryId: $categoryId, name: $name, nameAr: $nameAr, '
        'description: $description, descriptionAr: $descriptionAr, price: $price, '
        'image: $image, isFavorite: $isFavorite, categoryName: $categoryName}';
  }
}

class Price {
  int? large;
  int? medium;
  int? small;

  Price({this.large, this.medium, this.small});

  Price.fromJson(Map<String, dynamic> json) {
    large = json['large'];
    medium = json['medium'];
    small = json['small'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['large'] = large;
    data['medium'] = medium;
    data['small'] = small;
    return data;
  }

  @override
  String toString() {
    return 'Price{large: $large, medium: $medium, small: $small}';
  }
}
