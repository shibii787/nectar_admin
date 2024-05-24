import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nectar_admin/core/providers/firebase_providers.dart';
import 'package:nectar_admin/model/category_model.dart';
import 'package:nectar_admin/model/user_model.dart';

final addRepository = Provider((ref) => AddRepository(firestore: ref.watch(firestoreProvider)));

class AddRepository{
  final FirebaseFirestore _firestore;
  AddRepository({
   required FirebaseFirestore  firestore
}) : _firestore = firestore;

//A function to add subItem collection
CollectionReference get _categoryItems => _firestore.collection("categories");
CollectionReference get _stream => _firestore.collection("account");

collectionFunction({required CategoryModel categoryModel,required String docId}){
  _categoryItems.doc(docId).collection("subItems").add(categoryModel.toMap());
}

Stream<List<UserModel>> stream(){
  return _stream.snapshots().map((event) => event.docs.map((e) => UserModel.fromMap(e.data() as Map<String,dynamic>)).toList());
}

}