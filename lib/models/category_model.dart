class CategoryModel {
  final String? id;
  final String? title;
  final String? description;
  final String? price;
  final String? image;

  CategoryModel({
    this.id,
    this.title,
    this.description,
    this.price,
    this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "image": image,
      };

//   @override
//   String toString() {
//     return 'CategoryModel{id: $id, title: $title, description: $description, price: $price, image: $image}';
//   }
}

