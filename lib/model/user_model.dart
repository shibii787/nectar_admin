class UserModel{
  final String name;
  final String email;
  final String password;
  final String location;
  final int phoneNumber;
  final String address;
  final int pincode;
  final String image;
  final List cart;
  final List favourites;
  final String id;
  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.location,
    required this.phoneNumber,
    required this.address,
    required this.pincode,
    required this.image,
    required this.cart,
    required this.favourites,
    required this.id
  });
  Map<String,dynamic> tomap(){
    return{
      "name": this.name,
      "email": this.email,
      "password": this.password,
      "location": this.location,
      "phoneNumber": this.phoneNumber,
      "address": this.address,
      "pincode": this.pincode,
      "image": this.image,
      "cart": this.cart,
      "favourites": this.favourites,
      "id": this.id
    };
  }
  factory UserModel.fromMap(Map<String,dynamic>map){
    return UserModel(
        name: map["name"]??"",
        email: map["email"]??"",
        password: map["password"]??"",
        location: map["location"]??"",
        phoneNumber: map["phoneNumber"]??"",
        address: map["address"]??"",
        pincode: map["pincode"]??"",
        image: map["image"]?? "",
        cart: map["cart"]??[],
        favourites: map["favourites"]??[],
        id: map["id"]??""
    );
  }
  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? location,
    int? phoneNumber,
    String? address,
    int? pincode,
    String? image,
    List? cart,
    List? favourites,
    String? id
  }){
    return UserModel(
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        location: location ?? this.location,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        address: address ?? this.address,
        pincode: pincode ?? this.pincode,
        image: image ?? this.image,
        cart: cart ?? this.cart,
        favourites: favourites ?? this.favourites,
        id: id ?? this.id
    );
  }
}
