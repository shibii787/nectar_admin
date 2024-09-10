import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nectar_admin/model/adminModel.dart';

import '../repository/auth_repository.dart';

final authControlProvider = Provider((ref) => AuthController(authRepository: ref.read(authRepository)),);

class AuthController extends Notifier<bool>{
  final AuthRepository authRepository;
  AuthController({
    required this.authRepository
  });

  @override
  bool build() {
    // TODO: implement build
    return false; // Initial State is false
  }

  addAdmin({required AdminModel adminModel})  {
    authRepository.addAdmin(adminModel: adminModel);
  }

}