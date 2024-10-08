import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nectar_admin/core/common/firebase_constants.dart';
import 'package:nectar_admin/core/providers/firebase_providers.dart';
import 'package:nectar_admin/model/addCategory_model.dart';
import 'package:nectar_admin/model/adminModel.dart';
import 'package:nectar_admin/model/category_model.dart';
import 'package:nectar_admin/model/exclusive_model.dart';
import 'package:nectar_admin/model/grocery_model.dart';
import 'package:nectar_admin/model/user_model.dart';

import '../../model/bestSelling_model.dart';
import '../../model/pulses_model.dart';

final addRepository = Provider((ref) => AddRepository(firestore: ref.watch(firestoreProvider)));

class AddRepository{
  final FirebaseFirestore _firestore;
  AddRepository({
   required FirebaseFirestore  firestore
}) : _firestore = firestore;

// A function for Admin Users
  CollectionReference get _admins => _firestore.collection(FirebaseConstants.admins);

//A function to add category collection
CollectionReference get _categoryItems => _firestore.collection(FirebaseConstants.categories);

// A funtion to add subItem collection
// CollectionReference get _subItems => _categoryItems.doc().collection("subItems");

//A funtion to stream users
CollectionReference get _users => _firestore.collection(FirebaseConstants.account);

//A function to add bestSelling
CollectionReference get _bestsell => _firestore.collection(FirebaseConstants.bestSelling);

//A function to add exclisive list
CollectionReference get _exclusive => _firestore.collection(FirebaseConstants.exclusive);

// A function to add pulses list
  CollectionReference get _pulses => _firestore.collection(FirebaseConstants.pulses);

//   A funtion to add groceries list
  CollectionReference get _groceries => _firestore.collection(FirebaseConstants.groceries);

// To add Admins
adminFunc({required AdminModel adminModel, required String doCid}){
//_admins.add(adminModel.tomap());
_admins.doc(doCid).set(adminModel.tomap());
}

// A Collection to  Categories
  categoryFunction({required AddCategoryModel addCategoryModel}){
    _categoryItems.add(addCategoryModel.toMap()).then((value) {
      value.update({
       "id" : value.id,
      });
    });
  }

// A collection to add category sub list
collectionFunction({required CategoryModel categoryModel,required String docId}){
  _categoryItems.doc(docId).collection("subItems").add(categoryModel.toMap());
}

// A function that add exclusive list
exclusiveCollectionFunc({required ExclusiveModel exclusiveModel}){
  _exclusive.add(exclusiveModel.toMap()).then((value) {
    value.update({
      "id" : value.id
    });
  });
}

// A funtion that add best selling list
  sellingFunction({required BestSellingModel bestSellingModel}){
  _bestsell.add(bestSellingModel.toMap()).then((onValue){
    onValue.update({
      "id":onValue.id
    });
  });
  }
  
// A function that add pulses
pulsesfunction({required PulsesModel pulsesModel}){
    _pulses.add(pulsesModel.toMap()).then((value){
      value.update({
        "id":value.id
      });
    });
}

// A funtion that add groceries
  groceriesFunction({required GroceryModel groceryModel}){
    _groceries.add(groceryModel.toMap()).then((value){
      value.update({
        "id" : value.id
      });
    });
  }


//To stream to show admins
  Stream<List<AdminModel>> adminStream(){
    return _admins.snapshots().map((event) => event.docs.map((e) => AdminModel.fromMap(e.data() as Map<String,dynamic>)).toList());
  }

// A stream to show users
//   Stream<List<UserModel>> stream(){
//     return _users.snapshots().map((event) => event.docs.map((e) => UserModel.fromMap(e.data() as Map<String,dynamic>)).toList());
// }

Stream<QuerySnapshot<Object?>> streamUsers(){
  return _users.snapshots();
}

// A stream to show added categories
  Stream<List<AddCategoryModel>> addCategoryStreaM(){
    return _categoryItems.snapshots().map((event) => event.docs.map((e) => AddCategoryModel.fromMap(e.data() as Map<String,dynamic>)).toList());
  }

// A stream to show subItems
// Stream<List<CategoryModel>> subItemStream(){
//     return _subItems.snapshots().map((event) => event.docs.map((e) => CategoryModel.fromMap(e.data() as Map<String,dynamic>)).toList());
// }

// A stream to show exclusive list
Stream<List<ExclusiveModel>> exclusiveStream(){
  return _exclusive.snapshots().map((event) => event.docs.map((e) => ExclusiveModel.fromMap(e.data() as Map<String,dynamic>)).toList());
}

// A stream to show best Selling list
Stream<List<BestSellingModel>>bestsellingStream(){
  return _bestsell.snapshots().map((event)=>event.docs.map((e) => BestSellingModel.fromMap(e.data()as Map<String,dynamic>)).toList());
}
//A stream to show pulses
Stream<List<PulsesModel>>pulsesstream(){
    return _pulses.snapshots().map((event) => event.docs.map((e) => PulsesModel.fromMap(e.data()as Map<String,dynamic>)).toList());
}

// A stream to show groceries
Stream<List<GroceryModel>>addgroceriesStream(){
    return _groceries.snapshots().map((event) => event.docs.map((e) => GroceryModel.fromMap(e.data()as Map<String,dynamic>)).toList());
}

}