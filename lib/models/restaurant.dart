class Restaurant {
  int? id;
  String? title;
  String? address;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? counter;
  int? isSlide;
  String? description;

  Restaurant(
      {this.id,
        this.title,
        this.address,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.counter,
        this.isSlide,
        this.description});

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    address = json['address'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    counter = json['counter'];
    isSlide = json['is_slide'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['address'] = address;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['counter'] = counter;
    data['is_slide'] = isSlide;
    data['description'] = description;
    return data;
  }
}
