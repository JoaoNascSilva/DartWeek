import 'package:delivery_app/app/Helpers/rest_client.dart';
import 'package:delivery_app/app/models/menu_model.dart';

class MenuRepository {
  final RestClient restClient;

  MenuRepository(this.restClient);

  Future<List<MenuModel>> findAll() async {
    final response =
        await restClient.get<List<MenuModel>>('/menu/', decoder: (response) {
      if (response is List) {
        return response.map<MenuModel>((m) => MenuModel.fromMap(m)).toList();
      }
      return null;
    });

    if (response.hasError) {
      throw RestClientException('Erro ao buscar cardapio.');
    }

    return response.body;
  }
}
