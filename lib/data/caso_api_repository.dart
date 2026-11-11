import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:presente_campo/data/api_config.dart';
import 'package:presente_campo/data/caso_repository.dart';
import 'package:presente_campo/model/caso.dart';
import 'package:presente_campo/model/status_caso.dart';

class CasoApiRepository implements CasoRepository {
  final String baseUrl;

  CasoApiRepository({required this.baseUrl});

  @override
  Future<List<Caso>> buscarCasos() async {
    final uri = Uri.parse('$baseUrl/casos');

    final http.Response response;
    try {
      response = await http
          .get(uri, headers: {'Accept': 'application/json'})
          .timeout(ApiConfig.tempoLimite);
    } on TimeoutException {
      throw Exception('O servidor demorou para responder. Tente novamente.');
    } catch (_) {
      throw Exception('Sem conexão com o servidor. Verifique a internet.');
    }

    if (response.statusCode != 200) {
      throw Exception(
        'Não foi possível carregar os casos. '
        'Código HTTP: ${response.statusCode}',
      );
    }

    final lista = jsonDecode(response.body) as List<dynamic>;
    return lista
        .map((json) => Caso.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Caso> atualizarStatus(String id, StatusCaso status) async {
    final uri = Uri.parse('$baseUrl/casos/$id');

    final http.Response response;
    try {
      response = await http
          .patch(
            uri,
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({'status': status.name}),
          )
          .timeout(ApiConfig.tempoLimite);
    } on TimeoutException {
      throw Exception('O servidor demorou para responder. Tente novamente.');
    } catch (_) {
      throw Exception('Sem conexão com o servidor. Verifique a internet.');
    }

    if (response.statusCode != 200) {
      throw Exception(
        'Não foi possível atualizar o caso. '
        'Código HTTP: ${response.statusCode}',
      );
    }

    return Caso.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }
}
