class CategoryModel{
  final String name;
  final double price;
  final int qty;
  final String description;
  final String image;
  CategoryModel({
    required this.name,
    required this.price,
    required this.qty,
    required this.description,
    required this.image,
  });
  Map<String,dynamic> toMap(){
    return{
      "itemName" : this.name,
      "price" : this.price,
      "qty" : this.qty,
      "description":this.description,
      "image" : this.image,
    };
  }
  factory CategoryModel.fromMap(Map<String,dynamic>map){
    return CategoryModel(
        name: map["name"] ?? "",
        price: map["price"] ?? "",
        qty: map["qty"] ?? "",
        description: map["description"],
        image: map["image"] ?? ""
    );
  }
  CategoryModel copyWith({
    String? name,
    double? price,
    int? qty,
    String? description,
    String? image
  }){
    return CategoryModel(
        name: name ?? this.name,
        price: price ?? this.price,
        qty: qty ?? this.qty,
        description: description ?? this.description,
        image: image ?? this.image
    );
  }
}