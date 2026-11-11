import 'package:presente_campo/data/api_config.dart';
import 'package:presente_campo/data/caso_api_repository.dart';
import 'package:presente_campo/data/caso_local_repository.dart';
import 'package:presente_campo/model/caso.dart';
import 'package:presente_campo/model/status_caso.dart';

abstract interface class CasoRepository {
  Future<List<Caso>> buscarCasos();

  Future<Caso> atualizarStatus(String id, StatusCaso status);
}

CasoRepository criarCasoRepository() {
  if (ApiConfig.casosBaseUrl.isEmpty) {
    return CasoLocalRepository();
  }
  return CasoApiRepository(baseUrl: ApiConfig.casosBaseUrl);
}
