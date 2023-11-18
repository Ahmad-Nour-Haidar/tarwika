class OrderDetailsModel {
  int? orderId;
  int? userId;
  int? persons;
  int? status;
  int? count;
  int? itemPrice;
  int? totalPrice;
  String? name;
  String? nameAr;
  String? size;
  String? categoryName;

  OrderDetailsModel(
      {this.orderId,
      this.userId,
      this.persons,
      this.status,
      this.count,
      this.itemPrice,
      this.totalPrice,
      this.name,
      this.nameAr,
      this.size,
      this.categoryName});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    userId = json['user_id'];
    persons = json['persons'];
    status = int.parse(json['status'].toString());
    count = json['count'];
    itemPrice = int.parse(json['item_price'].toString());
    totalPrice = json['total_price'];
    name = json['name'];
    nameAr = json['name_ar'];
    size = json['size'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['user_id'] = userId;
    data['persons'] = persons;
    data['status'] = status;
    data['count'] = count;
    data['item_price'] = itemPrice;
    data['total_price'] = totalPrice;
    data['name'] = name;
    data['name_ar'] = nameAr;
    data['size'] = size;
    data['category_name'] = categoryName;
    return data;
  }
}
