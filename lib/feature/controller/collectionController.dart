import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nectar_admin/model/category_model.dart';

import '../repository/collectionAdding.dart';

final addCollectionController = Provider((ref) => AddCollectionController(addRepository: ref.watch(addCollectionRepository)));

class AddCollectionController{
  final AddCollectionRepository _addRepository;
  AddCollectionController({
    required AddCollectionRepository addRepository
}) : _addRepository = addRepository;

controlCollectionFunc({required CategoryModel categoryModel}){
  _addRepository.collectionFunction(categoryModel: categoryModel);
}

}