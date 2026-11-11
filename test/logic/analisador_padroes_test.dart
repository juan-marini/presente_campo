import 'package:flutter_test/flutter_test.dart';
import 'package:presente_campo/logic/analisador_padroes.dart';
import 'package:presente_campo/model/clima_dia.dart';
import 'package:presente_campo/model/resultado_padrao.dart';

import '../helpers.dart';

void main() {
  final analisador = AnalisadorPadroes();

  final clima = [
    ClimaDia(data: DateTime(2026, 9, 1), precipitacaoMm: 22.7),
    ClimaDia(data: DateTime(2026, 9, 2), precipitacaoMm: 0.2),
    ClimaDia(data: DateTime(2026, 9, 3), precipitacaoMm: 1.0),
    ClimaDia(data: DateTime(2026, 9, 4), precipitacaoMm: 0.0),
  ];

  test('deve calcular o percentual de faltas em dia de chuva', () {
    final faltas = [
      DateTime(2026, 9, 1),
      DateTime(2026, 9, 2),
      DateTime(2026, 9, 3),
      DateTime(2026, 9, 4),
    ];

    final resultado = analisador.analisar(faltas: faltas, climaDias: clima);

    expect(resultado.totalFaltas, 4);
    expect(resultado.faltasComChuva, 2);
    expect(resultado.percentual, closeTo(50.0, 0.01));
  });

  test('1,0 mm é o limite: conta como dia de chuva', () {
    final resultado = analisador.analisar(
      faltas: [DateTime(2026, 9, 3)],
      climaDias: clima,
    );

    expect(resultado.percentual, closeTo(100.0, 0.01));
  });

  test('faltas sem dado de clima não entram no percentual', () {
    final resultado = analisador.analisar(
      faltas: [DateTime(2026, 9, 1), DateTime(2026, 10, 20)],
      climaDias: clima,
    );

    expect(resultado.totalFaltas, 2);
    expect(resultado.faltasComDado, 1);
    expect(resultado.percentual, closeTo(100.0, 0.01));
  });

  test('sem faltas o percentual deve ser zero', () {
    final resultado = analisador.analisar(faltas: [], climaDias: clima);

    expect(resultado.totalFaltas, 0);
    expect(resultado.percentual, closeTo(0.0, 0.01));
  });

  test('turmas deve listar as turmas sem repetir e em ordem', () {
    final casos = [
      criarCasoTeste(id: '1', turma: '7º B'),
      criarCasoTeste(id: '2', turma: '6º A'),
      criarCasoTeste(id: '3', turma: '7º B'),
    ];

    expect(analisador.turmas(casos), ['6º A', '7º B']);
  });

  test('faltasDaTurma deve juntar as faltas dos casos da turma', () {
    final casos = [
      criarCasoTeste(id: '1', turma: '6º A', faltas: [DateTime(2026, 9, 1)]),
      criarCasoTeste(id: '2', turma: '7º B', faltas: [DateTime(2026, 9, 2)]),
      criarCasoTeste(id: '3', turma: '6º A', faltas: [DateTime(2026, 9, 3)]),
    ];

    final faltas = analisador.faltasDaTurma(casos, '6º A');

    expect(faltas, [DateTime(2026, 9, 1), DateTime(2026, 9, 3)]);
  });

  test('50% ou mais de faltas com chuva indica padrão de clima', () {
    const resultado = ResultadoPadrao(
      totalFaltas: 4,
      faltasComDado: 4,
      faltasComChuva: 2,
      percentual: 50.0,
    );

    expect(analisador.temPadraoDeChuva(resultado), true);
  });

  test('menos de 50% não indica padrão de clima', () {
    const resultado = ResultadoPadrao(
      totalFaltas: 4,
      faltasComDado: 4,
      faltasComChuva: 1,
      percentual: 25.0,
    );

    expect(analisador.temPadraoDeChuva(resultado), false);
  });

  test('periodo deve retornar a menor e a maior data', () {
    final faltas = [
      DateTime(2026, 9, 10),
      DateTime(2026, 9, 2),
      DateTime(2026, 9, 25),
    ];

    expect(analisador.primeiraData(faltas), DateTime(2026, 9, 2));
    expect(analisador.ultimaData(faltas), DateTime(2026, 9, 25));
  });
}
