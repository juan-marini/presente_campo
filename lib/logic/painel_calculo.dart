import 'package:presente_campo/model/caso.dart';
import 'package:presente_campo/model/motivo.dart';
import 'package:presente_campo/model/resumo_painel.dart';
import 'package:presente_campo/model/status_caso.dart';

class PainelCalculo {
  ResumoPainel calcular(List<Caso> casos) {
    final naoResolvidos =
        casos.where((caso) => caso.status != StatusCaso.resolvido).toList();

    final contagem = <Motivo, int>{};
    for (final caso in casos) {
      contagem[caso.motivo] = (contagem[caso.motivo] ?? 0) + 1;
    }
    final motivos = contagem.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return ResumoPainel(
      abertos: naoResolvidos.length,
      urgentes: naoResolvidos.where((caso) => caso.urgente).length,
      encaminhados: casos
          .where((caso) => caso.status == StatusCaso.encaminhado)
          .length,
      motivosMaisComuns: motivos,
    );
  }

  List<Caso> casosUrgentes(List<Caso> casos) {
    return casos
        .where((caso) => caso.urgente && caso.status != StatusCaso.resolvido)
        .toList();
  }
}
