class UserModel{
  final String name;
  final String email;
  final String password;
  final String location;
  final String phoneNumber;
  final String id;
  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.location,
    required this.phoneNumber,
    required this.id
  });
  Map<String,dynamic> tomap(){
    return{
      "name": this.name,
      "email": this.email,
      "password": this.password,
      "location": this.location,
      "phoneNumber":this.phoneNumber,
      "id":this.id
    };
  }
  factory UserModel.fromMap(Map<String,dynamic>map){
    return UserModel(
        name: map["name"]??"",
        email: map["email"]??"",
        password: map["password"]??"",
        location: map["location"]??"",
        phoneNumber: map["phoneNumber"]??"",
        id: map["id"]??""
    );
  }
  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? location,
    String? phoneNumber,
    String? id
  }){
    return UserModel(
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        location: location ?? this.location,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        id: id ?? this.id
    );
  }
}
