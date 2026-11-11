import 'package:presente_campo/model/caso.dart';
import 'package:presente_campo/model/status_caso.dart';

class CasoRegras {
  Caso encaminhar(Caso caso) {
    if (caso.status != StatusCaso.aberto) {
      throw ArgumentError('Só é possível encaminhar um caso aberto');
    }
    return caso.copyWith(status: StatusCaso.encaminhado);
  }

  Caso resolver(Caso caso) {
    if (caso.status == StatusCaso.resolvido) {
      throw ArgumentError('O caso já está resolvido');
    }
    return caso.copyWith(status: StatusCaso.resolvido);
  }

  bool podeEncaminhar(Caso caso) => caso.status == StatusCaso.aberto;

  bool podeResolver(Caso caso) => caso.status != StatusCaso.resolvido;

  Set<String> alternarFavorito(Set<String> favoritos, String id) {
    final novos = Set<String>.of(favoritos);
    if (novos.contains(id)) {
      novos.remove(id);
    } else {
      novos.add(id);
    }
    return novos;
  }
}
