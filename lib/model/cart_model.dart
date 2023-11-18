class CartModel {
  int? id;
  int? userId;
  int? itemId;
  int? categoryId;
  String? categoryName;
  String? name;
  String? nameAr;
  String? description;
  String? descriptionAr;
  String? size;
  String? price;
  int? count;
  String? itemPrice;
  int? totalPrice;
  String? image;

  CartModel(
      {this.id,
      this.userId,
      this.itemId,
      this.categoryId,
      this.categoryName,
      this.name,
      this.nameAr,
      this.description,
      this.descriptionAr,
      this.size,
      this.price,
      this.count,
      this.itemPrice,
      this.totalPrice,
      this.image});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    itemId = json['item_id'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    name = json['name'];
    nameAr = json['name_ar'];
    description = json['description'];
    descriptionAr = json['description_ar'];
    size = json['size'];
    price = json['price'];
    count = json['count'];
    itemPrice = json['item_price'];
    totalPrice = json['total_price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['item_id'] = itemId;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['name'] = name;
    data['name_ar'] = nameAr;
    data['description'] = description;
    data['description_ar'] = descriptionAr;
    data['size'] = size;
    data['price'] = price;
    data['count'] = count;
    data['item_price'] = itemPrice;
    data['total_price'] = totalPrice;
    data['image'] = image;
    return data;
  }
}
