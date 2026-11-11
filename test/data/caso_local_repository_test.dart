import 'package:flutter_test/flutter_test.dart';
import 'package:presente_campo/data/caso_local_repository.dart';
import 'package:presente_campo/model/status_caso.dart';

void main() {
  test('buscarCasos deve retornar os casos de demonstração', () async {
    final repository = CasoLocalRepository(atraso: Duration.zero);

    final casos = await repository.buscarCasos();

    expect(casos, isNotEmpty);
  });

  test('atualizarStatus deve manter a alteração na próxima busca', () async {
    final repository = CasoLocalRepository(atraso: Duration.zero);
    final casos = await repository.buscarCasos();
    final id = casos.first.id;

    await repository.atualizarStatus(id, StatusCaso.resolvido);
    final depois = await repository.buscarCasos();

    expect(depois.firstWhere((c) => c.id == id).status, StatusCaso.resolvido);
  });

  test('atualizarStatus com id inexistente deve gerar erro', () async {
    final repository = CasoLocalRepository(atraso: Duration.zero);

    expect(
      () => repository.atualizarStatus('nao-existe', StatusCaso.resolvido),
      throwsArgumentError,
    );
  });
}
