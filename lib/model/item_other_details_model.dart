class ItemOtherDetailsModel {
  int? id;
  int? orderId;
  int? userId;
  int? itemId;
  int? count;
  double? itemPrice;
  String? size;

  ItemOtherDetailsModel(
      {this.id,
      this.orderId,
      this.userId,
      this.itemId,
      this.count,
      this.itemPrice,
      this.size});

  ItemOtherDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    userId = json['user_id'];
    itemId = json['item_id'];
    count = json['count'];
    itemPrice = double.tryParse('${json['item_price']}');
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['user_id'] = userId;
    data['item_id'] = itemId;
    data['count'] = count;
    data['item_price'] = itemPrice;
    data['size'] = size;
    return data;
  }
}
