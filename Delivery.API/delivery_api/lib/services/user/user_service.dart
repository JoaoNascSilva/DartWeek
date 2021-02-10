import 'package:delivery_api/application/entities/user.dart';
import 'package:delivery_api/application/helpers/cryptHelper.dart';
import 'package:delivery_api/modules/users/view_model/register_input_model.dart';
import 'package:delivery_api/modules/users/view_model/user_login_view_model.dart';
import 'package:delivery_api/repositories/user/IUserRepository.dart';
import 'package:delivery_api/services/user/IUserService.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IUserService)
class UserService implements IUserService {
  final IUserRepository _repository;

  UserService(this._repository);

  @override
  Future<void> register(RegisterInputModel inputModel) async {
    final passwordCrypt = CrypHelper.generateSHA256Hash(inputModel.password);
    inputModel.password = passwordCrypt;

    await _repository.saveUser(inputModel);
  }

  @override
  Future<User> login(UserLoginModel viewModel) async {
    final passwordCrypt = CrypHelper.generateSHA256Hash(viewModel.password);
    viewModel.password = passwordCrypt;

    return await _repository.login(viewModel);
  }
}
