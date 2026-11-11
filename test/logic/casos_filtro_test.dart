import 'package:flutter_test/flutter_test.dart';
import 'package:presente_campo/logic/casos_filtro.dart';
import 'package:presente_campo/model/motivo.dart';
import 'package:presente_campo/model/status_caso.dart';

import '../helpers.dart';

void main() {
  final filtro = CasosFiltro();
  final casos = [
    criarCasoTeste(id: '1', aluno: 'Ana Souza', motivo: Motivo.transporte),
    criarCasoTeste(
      id: '2',
      aluno: 'Bruno Lima',
      motivo: Motivo.saude,
      status: StatusCaso.encaminhado,
    ),
    criarCasoTeste(id: '3', aluno: 'Carla Andrade', motivo: Motivo.saude),
  ];

  test('sem filtros deve retornar todos os casos', () {
    final resultado = filtro.filtrar(casos: casos);

    expect(resultado.length, 3);
  });

  test('busca deve ignorar maiúsculas e minúsculas', () {
    final resultado = filtro.filtrar(casos: casos, busca: 'aNA');

    expect(resultado.map((c) => c.id), ['1']);
  });

  test('busca com espaços nas pontas deve funcionar', () {
    final resultado = filtro.filtrar(casos: casos, busca: '  bruno ');

    expect(resultado.map((c) => c.id), ['2']);
  });

  test('filtro por motivo', () {
    final resultado = filtro.filtrar(casos: casos, motivo: Motivo.saude);

    expect(resultado.map((c) => c.id), ['2', '3']);
  });

  test('motivo e status devem combinar', () {
    final resultado = filtro.filtrar(
      casos: casos,
      motivo: Motivo.saude,
      status: StatusCaso.aberto,
    );

    expect(resultado.map((c) => c.id), ['3']);
  });

  test('busca sem resultado deve retornar lista vazia', () {
    final resultado = filtro.filtrar(casos: casos, busca: 'zzz');

    expect(resultado, isEmpty);
  });
}
