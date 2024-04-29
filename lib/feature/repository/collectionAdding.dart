import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nectar_admin/core/providers/firebase_providers.dart';
import 'package:nectar_admin/model/category_model.dart';

final addCollectionRepository = Provider((ref) => AddCollectionRepository(firestore: ref.watch(firestoreProvider)));

class AddCollectionRepository{
  final FirebaseFirestore _firestore;
  AddCollectionRepository({
   required FirebaseFirestore  firestore
}) : _firestore = firestore;

CollectionReference get _items => _firestore.collection("items");

collectionFunction({required CategoryModel categoryModel}){
  _items.add(categoryModel.toMap());
}

}