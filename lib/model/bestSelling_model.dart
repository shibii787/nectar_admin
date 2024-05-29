class BestSellingModel{
  final String itemName;
  final double price;
  final int qty;
  final String description;
  final String image;
  final String id;
  BestSellingModel({
    required this.itemName,
    required this.price,
    required this.qty,
    required this.description,
    required this.image,
    required this.id
  });
  Map<String,dynamic> toMap(){
    return{
      "itemName" : this.itemName,
      "price" : this.price,
      "qty" : this.qty,
      "description":this.description,
      "image" : this.image,
      "id": this.id

    };
  }
  factory BestSellingModel.fromMap(Map<String,dynamic>map){
    return BestSellingModel(
        itemName: map["itemName"] ?? "",
        price: map["price"] ?? "",
        qty: map["qty"] ?? "",
        description: map["description"] ?? "",
        image: map["image"] ?? "",
        id: map["id"] ?? ""
    );
  }
  BestSellingModel copyWith({
    String? itemName,
    double? price,
    int? qty,
    String? description,
    String? image,
    String? id
  }){
    return BestSellingModel(
        itemName: itemName ?? this.itemName,
        price: price ?? this.price,
        qty: qty ?? this.qty,
        description: description ?? this.description,
        image: image ?? this.image,
        id: id ?? this.id
    );
  }
}