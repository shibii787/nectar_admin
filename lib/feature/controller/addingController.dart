import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nectar_admin/model/bestSelling_model.dart';
import 'package:nectar_admin/model/category_model.dart';
import 'package:nectar_admin/model/exclusive_model.dart';

import '../../model/user_model.dart';
import '../repository/addingRepository.dart';


final addController = Provider((ref) => AddController(addRepository: ref.watch(addRepository)));

final streamdataProvider = StreamProvider((ref) => ref.watch(addController).streamController());

class AddController{
  final AddRepository _addRepository;
  AddController({
    required AddRepository addRepository
}) : _addRepository = addRepository;

controlCollectionFunc({required CategoryModel categoryModel,required String docIdss}){
  _addRepository.collectionFunction(categoryModel: categoryModel,docId: docIdss);
}

  Stream<List<UserModel>> streamController(){
  return _addRepository.stream();
}

controlExclusiveFunc({required ExclusiveModel exclusiveModel}){
  _addRepository.exclusiveCollectionFunc(exclusiveModel: exclusiveModel);
}

controllBestsellingFunction({required BestSellingModel bestsellingModel}){
  _addRepository.sellingFunction(bestSellingModel: bestsellingModel);
}

}