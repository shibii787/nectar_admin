import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nectar_admin/model/addCategory_model.dart';
import 'package:nectar_admin/model/bestSelling_model.dart';
import 'package:nectar_admin/model/category_model.dart';
import 'package:nectar_admin/model/exclusive_model.dart';

import '../../model/user_model.dart';
import '../repository/addingRepository.dart';


final addController = Provider((ref) => AddController(addRepository: ref.watch(addRepository)));

// Provider funtion for users
final streamdataProvider = StreamProvider((ref) => ref.watch(addController).streamController());

// provider function for Add Category
final addCategoryStreamProvider = StreamProvider((ref) => ref.watch(addController).addCategoryStreamController());

// provider for subItems
//final subItemProvider = StreamProvider((ref) => ref.watch(addController).subItemStreamController());

// Provider funtion for best selling list
final bestsellingProvider = StreamProvider((ref) => ref.watch(addController).bestsellingStream());

// Provider funtion for exclusive list
final exclusiveStreamProvider = StreamProvider((ref) => ref.watch(addController).exclusiveStreamController());

class AddController{
  final AddRepository _addRepository;
  AddController({
    required AddRepository addRepository
}) : _addRepository = addRepository;

// A funtion to add AddCategory model
addCategoryControlFunction({required AddCategoryModel addCategoryModel}){
  _addRepository.categoryFunction(addCategoryModel: addCategoryModel);
}

// A funtion to add category sub list
controlCollectionFunc({required CategoryModel categoryModel,required String docIdss}){
  _addRepository.collectionFunction(categoryModel: categoryModel,docId: docIdss);
}

// A stream to show users
  Stream<List<UserModel>> streamController(){
  return _addRepository.stream();
}

// To show addCategory list
  Stream<List<AddCategoryModel>> addCategoryStreamController(){
  return _addRepository.addCategoryStream();
  }

//A stream to show subItem collection
// Stream<List<CategoryModel>> subItemStreamController(){
//   return _addRepository.subItemStream();
// }

// A stream to show bestSelling list
Stream<List<BestSellingModel>>bestsellingStream(){
  return _addRepository.bestsellingStream();
}

// A funtion to show exclusive list
controlExclusiveFunc({required ExclusiveModel exclusiveModel}){
  _addRepository.exclusiveCollectionFunc(exclusiveModel: exclusiveModel);
}

// A function to show best selling list
controllBestsellingFunction({required BestSellingModel bestsellingModel}){
  _addRepository.sellingFunction(bestSellingModel: bestsellingModel);
}

// A stream to show excclusive list
Stream<List<ExclusiveModel>> exclusiveStreamController(){
  return _addRepository.exclusiveStream();
}

}