class PulsesModel{
  final String name;
  final double price;
  final int qty;
  final String description;
  final String image;
  final String id;
  PulsesModel({
    required this.name,
    required this.price,
    required this.qty,
    required this.description,
    required this.image,
    required this.id
  });
  Map<String,dynamic> toMap(){
    return{
      "itemName" : this.name,
      "price" : this.price,
      "qty" : this.qty,
      "description":this.description,
      "image" : this.image,
      "id": this.id

    };
  }
  factory PulsesModel.fromMap(Map<String,dynamic>map){
    return PulsesModel(
        name: map["name"] ?? "",
        price: map["price"] ?? "",
        qty: map["qty"] ?? "",
        description: map["description"] ?? "",
        image: map["image"] ?? "",
        id: map["id"] ?? ""
    );
  }
   PulsesModel copyWith({
    String? itemName,
    double? price,
    int? qty,
    String? description,
    String? image,
    String? id
  }){
    return PulsesModel(
        name: itemName ?? this.name,
        price: price ?? this.price,
        qty: qty ?? this.qty,
        description: description ?? this.description,
        image: image ?? this.image,
        id: id ?? this.id
    );
  }
}