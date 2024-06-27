class AdminModel{
  final String name;
  final String password;
  final String id;
  AdminModel({
    required this.name,
    required this.password,
    required this.id
});
  Map<String,dynamic>tomap(){
    return {
      "name" : this.name,
      "password" : this.password,
      "id" : this.id
    };
  }
  factory AdminModel.fromMap(Map<String,dynamic>map){
    return AdminModel(
        name: map["name"] ?? "",
        password: map["password"] ?? "",
        id: map["id"] ?? ""
    );
  }
  AdminModel copyWith({
    String? name,
    String? password,
    String? id
}){
    return AdminModel(
        name: name ?? this.name,
        password: password ?? this.password,
        id: id ?? this.id
    );
}
}