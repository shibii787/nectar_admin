import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nectar_admin/core/providers/firebase_providers.dart';
import 'package:nectar_admin/model/addCategory_model.dart';
import 'package:nectar_admin/model/category_model.dart';
import 'package:nectar_admin/model/exclusive_model.dart';
import 'package:nectar_admin/model/user_model.dart';

import '../../model/bestSelling_model.dart';

final addRepository = Provider((ref) => AddRepository(firestore: ref.watch(firestoreProvider)));

class AddRepository{
  final FirebaseFirestore _firestore;
  AddRepository({
   required FirebaseFirestore  firestore
}) : _firestore = firestore;

//A function to add category collection
CollectionReference get _categoryItems => _firestore.collection("categories");

// A funtion to ad subItem collection
// CollectionReference get _subItems => _categoryItems.doc().collection("subItems");

//A funtion to add users
CollectionReference get _stream => _firestore.collection("account");

//A function to add bestSelling
CollectionReference get _bestsell => _firestore.collection("bestSelling");

//A function to add exclisive list
CollectionReference get _exclusive => _firestore.collection("exclusive");

// A Collection to show Categories
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

// A stream to show users
  Stream<List<UserModel>> stream(){
    return _stream.snapshots().map((event) => event.docs.map((e) => UserModel.fromMap(e.data() as Map<String,dynamic>)).toList());
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

}