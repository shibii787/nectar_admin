import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nectar_admin/core/providers/firebase_providers.dart';
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

//A function to add subItem collection
CollectionReference get _categoryItems => _firestore.collection("categories");

//A funtion to add users
CollectionReference get _stream => _firestore.collection("account");
//A function to add bestSelling
CollectionReference get _bestsell => _firestore.collection("bestSelling");

//A function to add exclisive list
CollectionReference get _exclusive => _firestore.collection("exclusive");

collectionFunction({required CategoryModel categoryModel,required String docId}){
  _categoryItems.doc(docId).collection("subItems").add(categoryModel.toMap());
}


Stream<List<UserModel>> stream(){
  return _stream.snapshots().map((event) => event.docs.map((e) => UserModel.fromMap(e.data() as Map<String,dynamic>)).toList());
}

exclusiveCollectionFunc({required ExclusiveModel exclusiveModel}){
  _exclusive.add(exclusiveModel.toMap()).then((value) {
    value.update({
      "id" : value.id
    });
  });
}
  sellingFunction({required BestSellingModel bestSellingModel}){
  _bestsell.add(bestSellingModel.toMap()).then((onValue){
    onValue.update({
      "id":onValue.id
    });
  });
  }


Stream<List<ExclusiveModel>> exclusiveStream(){
  return _exclusive.snapshots().map((event) => event.docs.map((e) => ExclusiveModel.fromMap(e.data() as Map<String,dynamic>)).toList());
}
Stream<List<BestSellingModel>>bestsellingStream(){
  return _bestsell.snapshots().map((event)=>event.docs.map((e) => BestSellingModel.fromMap(e.data()as Map<String,dynamic>)).toList());
}

}