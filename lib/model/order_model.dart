class OrderModel {
  int? id;
  int? userId;
  int? totalPrice;
  int? totalCount;
  String? status;
  int? persons;
  String? reservationDateTime;

  OrderModel(
      {this.id,
      this.userId,
      this.totalPrice,
      this.totalCount,
      this.status,
      this.persons,
      this.reservationDateTime});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    totalPrice = json['total_price'];
    totalCount = json['total_count'];
    status = json['status'];
    persons = json['persons'];
    reservationDateTime = json['reservation_date_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['total_price'] = totalPrice;
    data['total_count'] = totalCount;
    data['status'] = status;
    data['persons'] = persons;
    data['reservation_date_time'] = reservationDateTime;
    return data;
  }
}
