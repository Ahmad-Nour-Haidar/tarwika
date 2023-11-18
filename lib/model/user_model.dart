class User {
  Data? data;
  String? token;

  User({this.data, this.token});

  User.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? image;
  String? phone;
  String? emailVerifiedAt;

  Data({
    this.id,
    this.name,
    this.email,
    this.image,
    this.phone,
    this.emailVerifiedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    phone = json['phone'];
    emailVerifiedAt = json['email_verified_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['image'] = image;
    data['phone'] = phone;
    data['email_verified_at'] = emailVerifiedAt;
    return data;
  }
}
