import 'package:delivery_api/application/entities/user.dart';
import 'package:delivery_api/modules/users/view_model/register_input_model.dart';
import 'package:delivery_api/modules/users/view_model/user_login_view_model.dart';

abstract class IUserService {
  Future<void> register(RegisterInputModel inputModel);

  Future<User> login(UserLoginModel viewModel);
}
