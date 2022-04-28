class Basket {
  int? id;
  int? productId;
  int? count;
  String? createdAt;
  String? updatedAt;
  int? restaurantId;
  int? userId;
  int? isPaying;

  Basket(
      {this.id,
      this.productId,
      this.count,
      this.createdAt,
      this.updatedAt,
      this.restaurantId,
      this.userId,
      this.isPaying});

  Basket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    count = json['count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    restaurantId = json['restaurant_id'];
    userId = json['user_id'];
    isPaying = json['is_paying'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['product_id'] = productId;
    data['count'] = count;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['restaurant_id'] = restaurantId;
    data['user_id'] = userId;
    data['is_paying'] = isPaying;
    return data;
  }
}
