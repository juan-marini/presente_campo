import 'package:presente_campo/data/caso_repository.dart';
import 'package:presente_campo/data/casos_fake.dart';
import 'package:presente_campo/model/caso.dart';
import 'package:presente_campo/model/status_caso.dart';

class CasoLocalRepository implements CasoRepository {
  static final List<Caso> _casos = getAllCasosDemonstracao();

  final Duration atraso;

  CasoLocalRepository({this.atraso = const Duration(milliseconds: 800)});

  @override
  Future<List<Caso>> buscarCasos() async {
    await Future.delayed(atraso);
    return List.of(_casos);
  }

  @override
  Future<Caso> atualizarStatus(String id, StatusCaso status) async {
    await Future.delayed(atraso);
    final indice = _casos.indexWhere((caso) => caso.id == id);
    if (indice == -1) {
      throw ArgumentError('Caso não encontrado');
    }
    final atualizado = _casos[indice].copyWith(status: status);
    _casos[indice] = atualizado;
    return atualizado;
  }
}
