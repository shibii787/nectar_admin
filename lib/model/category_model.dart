class CategoryModel{
  final String itemName;
  final double price;
  final int qty;
  final String image;
  CategoryModel({
    required this.itemName,
    required this.price,
    required this.qty,
    required this.image,
});
  Map<String,dynamic> toMap(){
    return{
      "ItemName" : this.itemName,
      "price" : this.price,
      "qty" : this.qty,
      "image" : this.image,
    };
  }
  factory CategoryModel.fromMap(Map<String,dynamic>map){
    return CategoryModel(
        itemName: map["itemName"] ?? "",
        price: map["price"] ?? "",
        qty: map["qty"] ?? "",
        image: map["image"] ?? ""
    );
  }
  CategoryModel copyWith({
    String? itemName,
    double? price,
    int? qty,
    String? image
}){
    return CategoryModel(
        itemName: itemName ?? this.itemName,
        price: price ?? this.price,
        qty: qty ?? this.qty,
        image: image ?? this.image
    );
  }
}