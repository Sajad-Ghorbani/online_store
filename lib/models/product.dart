class Product {
  int? id;
  String? name;
  int? price;
  int? categoryId;
  int? restaurantId;
  String? createdAt;
  String? updatedAt;

  Product(
      {this.id,
        this.name,
        this.price,
        this.categoryId,
        this.restaurantId,
        this.createdAt,
        this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    categoryId = json['category_id'];
    restaurantId = json['restaurant_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['category_id'] = categoryId;
    data['restaurant_id'] = restaurantId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
