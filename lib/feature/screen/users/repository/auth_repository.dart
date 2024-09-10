import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nectar_admin/core/common/firebase_constants.dart';
import 'package:nectar_admin/core/providers/firebase_providers.dart';
import 'package:nectar_admin/model/adminModel.dart';

final authRepository = Provider((ref) => AuthRepository(
    firestore: ref.read(firestoreProvider), firebaseAuth: ref.read(authProvider)),);

class AuthRepository{
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;
  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth firebaseAuth,
  }) : _firestore = firestore, _firebaseAuth = firebaseAuth;

  addAdmin({required AdminModel adminModel}) async {
    try{
      var settings = await _firestore.collection(FirebaseConstants.settings).doc('settings').get();
      int id = 1;
      id = settings.data()?['adminID'] ?? id;
      String adminID = "ADMIN$id";

      settings.reference.update({
        "adminID" : FieldValue.increment(1)
      });
      
      DocumentReference ref = _firestore.collection(FirebaseConstants.admins).doc(adminID);

      AdminModel adModel = adminModel.copyWith(
        id: ref.id
      );

      return ref.set(adModel.tomap());

    } catch (error) {
      return print("Error adding Admin - $error");
    }
  }

}