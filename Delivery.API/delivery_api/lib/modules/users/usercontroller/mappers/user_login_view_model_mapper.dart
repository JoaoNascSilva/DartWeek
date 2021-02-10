import 'package:delivery_api/modules/users/view_model/user_login_view_model.dart';

class UserLoginViewModelMapper {
  final Map<String, dynamic> _requestMap;

  UserLoginViewModelMapper(this._requestMap);

  UserLoginModel mapper() {
    return UserLoginModel(
      _requestMap['email'],
      _requestMap['password'],
    );
  }
}
