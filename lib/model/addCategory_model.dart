import 'package:cloud_firestore/cloud_firestore.dart';

class AddCategoryModel{
  final String name;
  final String image;
  final Timestamp time;
  final String id;
  AddCategoryModel({
    required this.name,
    required this.image,
    required this.time,
    required this.id,
  });
Map<String,dynamic> toMap(){
  return {
    "name" : this.name,
    "image" : this.image,
    "time" : this.time,
    "id" : this.id
  };
}
factory AddCategoryModel.fromMap(Map<String,dynamic>map){
  return AddCategoryModel(
      name: map["name"] ?? "",
      image: map["image"] ?? "",
      time: map["time"] ?? "",
      id: map["id"] ?? ""
  );
}
AddCategoryModel copyWith({
    String? name,
    String? image,
    Timestamp? time,
    String? id,
}){
  return AddCategoryModel(
      name: name ?? this.name,
      image: image ?? this.image,
      time: time ?? this.time,
      id: id ?? this.id
  );
}
}