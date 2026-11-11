import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:presente_campo/data/api_config.dart';
import 'package:presente_campo/model/clima_dia.dart';

class ClimaService {
  Future<List<ClimaDia>> buscarChuva({
    required DateTime inicio,
    required DateTime fim,
  }) async {
    final uri = Uri.parse(
      '${ApiConfig.openMeteoBaseUrl}'
      '?latitude=${ApiConfig.latitudeEscola}'
      '&longitude=${ApiConfig.longitudeEscola}'
      '&start_date=${_formatar(inicio)}'
      '&end_date=${_formatar(fim)}'
      '&daily=precipitation_sum'
      '&timezone=America/Sao_Paulo',
    );

    final http.Response response;
    try {
      response = await http
          .get(uri, headers: {'Accept': 'application/json'})
          .timeout(ApiConfig.tempoLimite);
    } on TimeoutException {
      throw Exception('O serviço de clima demorou para responder.');
    } catch (_) {
      throw Exception('Sem conexão com a internet. Verifique e tente de novo.');
    }

    if (response.statusCode != 200) {
      throw Exception(
        'Não foi possível consultar o clima. '
        'Código HTTP: ${response.statusCode}',
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final dias = ClimaDia.listaFromJson(json);

    if (dias.isEmpty) {
      throw Exception('Não há dados de chuva para esse período.');
    }

    return dias;
  }

  String _formatar(DateTime data) {
    final mes = data.month.toString().padLeft(2, '0');
    final dia = data.day.toString().padLeft(2, '0');
    return '${data.year}-$mes-$dia';
  }
}
