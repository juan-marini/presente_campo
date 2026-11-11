import 'package:presente_campo/model/caso.dart';
import 'package:presente_campo/model/motivo.dart';
import 'package:presente_campo/model/status_caso.dart';

class CasosFiltro {
  List<Caso> filtrar({
    required List<Caso> casos,
    String busca = '',
    Motivo? motivo,
    StatusCaso? status,
  }) {
    final termo = busca.trim().toLowerCase();

    return casos.where((caso) {
      final nomeOk = termo.isEmpty || caso.aluno.toLowerCase().contains(termo);
      final motivoOk = motivo == null || caso.motivo == motivo;
      final statusOk = status == null || caso.status == status;
      return nomeOk && motivoOk && statusOk;
    }).toList();
  }
}
