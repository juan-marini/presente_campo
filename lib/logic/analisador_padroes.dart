import 'package:presente_campo/model/caso.dart';
import 'package:presente_campo/model/clima_dia.dart';
import 'package:presente_campo/model/resultado_padrao.dart';

class AnalisadorPadroes {
  static const double limiteChuvaMm = 1.0;

  ResultadoPadrao analisar({
    required List<DateTime> faltas,
    required List<ClimaDia> climaDias,
  }) {
    final chuvaPorDia = <String, double>{};
    for (final dia in climaDias) {
      chuvaPorDia[_chave(dia.data)] = dia.precipitacaoMm;
    }

    var comDado = 0;
    var comChuva = 0;
    for (final falta in faltas) {
      final chuva = chuvaPorDia[_chave(falta)];
      if (chuva == null) {
        continue;
      }
      comDado++;
      if (chuva >= limiteChuvaMm) {
        comChuva++;
      }
    }

    return ResultadoPadrao(
      totalFaltas: faltas.length,
      faltasComDado: comDado,
      faltasComChuva: comChuva,
      percentual: comDado == 0 ? 0.0 : comChuva / comDado * 100,
    );
  }

  bool temPadraoDeChuva(ResultadoPadrao resultado) {
    return resultado.faltasComDado > 0 && resultado.percentual >= 50.0;
  }

  List<String> turmas(List<Caso> casos) {
    final turmas = casos.map((caso) => caso.turma).toSet().toList();
    turmas.sort();
    return turmas;
  }

  List<DateTime> faltasDaTurma(List<Caso> casos, String turma) {
    return casos
        .where((caso) => caso.turma == turma)
        .expand((caso) => caso.faltas)
        .toList();
  }

  DateTime primeiraData(List<DateTime> datas) {
    return datas.reduce((a, b) => a.isBefore(b) ? a : b);
  }

  DateTime ultimaData(List<DateTime> datas) {
    return datas.reduce((a, b) => a.isAfter(b) ? a : b);
  }

  String _chave(DateTime data) => '${data.year}-${data.month}-${data.day}';
}
