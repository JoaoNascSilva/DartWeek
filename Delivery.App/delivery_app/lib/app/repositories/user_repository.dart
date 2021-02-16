import 'package:delivery_app/app/Helpers/rest_client.dart';
import 'package:delivery_app/app/models/user_model.dart';
import 'package:delivery_app/app/view_models/register_user_input_model.dart';

class UserRepository {
  final RestClient restClient;

  UserRepository(this.restClient);

  Future<UserModel> login(String email, String password) async {
    final response = await restClient.post(
      '/user/auth',
      {
        'email': email,
        'password': password,
      },
      decoder: (response) {
        if (response != '') return UserModel.fromMap(response);
      },
    );

    if (response.hasError) {
      String message = 'Erro ao autenticar usuario.';
      if (response.statusCode == 403) {
        message = 'Usuario ou senha invalidos.';
      }

      throw RestClientException(message);
    }
    return response.body;
  }

  Future<void> saveUser(RegisterUserInputModel model) async {
    final response = await restClient.post('/user/', {
      'name': model.name,
      'email': model.email,
      'password': model.password,
    });

    if (response.hasError) {
      throw RestClientException('Erro ao registrar usuario.');
    }
  }
}
