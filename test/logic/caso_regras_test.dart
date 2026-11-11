import 'package:flutter_test/flutter_test.dart';
import 'package:presente_campo/logic/caso_regras.dart';
import 'package:presente_campo/model/status_caso.dart';

import '../helpers.dart';

void main() {
  final regras = CasoRegras();

  test('encaminhar caso aberto deve mudar para encaminhado', () {
    final caso = criarCasoTeste(status: StatusCaso.aberto);

    final resultado = regras.encaminhar(caso);

    expect(resultado.status, StatusCaso.encaminhado);
  });

  test('encaminhar caso já encaminhado deve gerar erro', () {
    final caso = criarCasoTeste(status: StatusCaso.encaminhado);

    expect(() => regras.encaminhar(caso), throwsArgumentError);
  });

  test('encaminhar caso resolvido deve gerar erro', () {
    final caso = criarCasoTeste(status: StatusCaso.resolvido);

    expect(() => regras.encaminhar(caso), throwsArgumentError);
  });

  test('resolver caso aberto ou encaminhado deve mudar para resolvido', () {
    final aberto = criarCasoTeste(status: StatusCaso.aberto);
    final encaminhado = criarCasoTeste(status: StatusCaso.encaminhado);

    expect(regras.resolver(aberto).status, StatusCaso.resolvido);
    expect(regras.resolver(encaminhado).status, StatusCaso.resolvido);
  });

  test('resolver caso já resolvido deve gerar erro', () {
    final caso = criarCasoTeste(status: StatusCaso.resolvido);

    expect(() => regras.resolver(caso), throwsArgumentError);
  });

  test('alternarFavorito deve adicionar quando o id não está no conjunto', () {
    final resultado = regras.alternarFavorito({'1'}, '2');

    expect(resultado, {'1', '2'});
  });

  test('alternarFavorito deve remover quando o id já está no conjunto', () {
    final favoritos = {'1', '2'};

    final resultado = regras.alternarFavorito(favoritos, '2');

    expect(resultado, {'1'});
    expect(favoritos, {'1', '2'});
  });
}
