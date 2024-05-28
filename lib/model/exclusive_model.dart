class ExclusiveModel{
  final String itemName;
  final double price;
  final int qty;
  final String description;
  final String image;
  ExclusiveModel({
    required this.itemName,
    required this.price,
    required this.qty,
    required this.description,
    required this.image,
  });
  Map<String,dynamic> toMap(){
    return{
      "ItemName" : this.itemName,
      "price" : this.price,
      "qty" : this.qty,
      "description":this.description,
      "image" : this.image,
    };
  }
  factory ExclusiveModel.fromMap(Map<String,dynamic>map){
    return ExclusiveModel(
        itemName: map["itemName"] ?? "",
        price: map["price"] ?? "",
        qty: map["qty"] ?? "",
        description: map["description"],
        image: map["image"] ?? ""
    );
  }
  ExclusiveModel copyWith({
    String? itemName,
    double? price,
    int? qty,
    String? description,
    String? image
  }){
    return ExclusiveModel(
        itemName: itemName ?? this.itemName,
        price: price ?? this.price,
        qty: qty ?? this.qty,
        description: description ?? this.description,
        image: image ?? this.image
    );
  }
}