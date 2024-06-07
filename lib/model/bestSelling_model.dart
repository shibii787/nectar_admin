class BestSellingModel{
  final String name;
  final double price;
  final int qty;
  final String description;
  final String image;
  final String id;
  BestSellingModel({
    required this.name,
    required this.price,
    required this.qty,
    required this.description,
    required this.image,
    required this.id
  });
  Map<String,dynamic> toMap(){
    return{
      "name" : this.name,
      "price" : this.price,
      "qty" : this.qty,
      "description":this.description,
      "image" : this.image,
      "id": this.id

    };
  }
  factory BestSellingModel.fromMap(Map<String,dynamic>map){
    return BestSellingModel(
        name: map["name"] ?? "",
        price:  (map["price"] is num) ? (map["price"] as num).toDouble() : 0.0,
        qty: map["qty"] ?? 0,
        description: map["description"] ?? "",
        image: map["image"] ?? "",
        id: map["id"] ?? ""
    );
  }
  BestSellingModel copyWith({
    String? name,
    double? price,
    int? qty,
    String? description,
    String? image,
    String? id
  }){
    return BestSellingModel(
        name: name ?? this.name,
        price: price ?? this.price,
        qty: qty ?? this.qty,
        description: description ?? this.description,
        image: image ?? this.image,
        id: id ?? this.id
    );
  }
}