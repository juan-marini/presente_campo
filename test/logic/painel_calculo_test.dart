import 'package:flutter_test/flutter_test.dart';
import 'package:presente_campo/logic/painel_calculo.dart';
import 'package:presente_campo/model/motivo.dart';
import 'package:presente_campo/model/status_caso.dart';

import '../helpers.dart';

void main() {
  final calculo = PainelCalculo();
  final casos = [
    criarCasoTeste(id: '1', motivo: Motivo.saude, urgente: true),
    criarCasoTeste(
      id: '2',
      motivo: Motivo.saude,
      status: StatusCaso.encaminhado,
    ),
    criarCasoTeste(id: '3', motivo: Motivo.transporte),
    criarCasoTeste(
      id: '4',
      motivo: Motivo.clima,
      status: StatusCaso.resolvido,
      urgente: true,
    ),
  ];

  test('abertos devem contar todos os casos não resolvidos', () {
    final resumo = calculo.calcular(casos);

    expect(resumo.abertos, 3);
  });

  test('urgentes resolvidos não devem contar', () {
    final resumo = calculo.calcular(casos);

    expect(resumo.urgentes, 1);
  });

  test('encaminhados devem contar só o status encaminhado', () {
    final resumo = calculo.calcular(casos);

    expect(resumo.encaminhados, 1);
  });

  test('motivos mais comuns devem vir ordenados por quantidade', () {
    final resumo = calculo.calcular(casos);

    expect(resumo.motivosMaisComuns.first.key, Motivo.saude);
    expect(resumo.motivosMaisComuns.first.value, 2);
    expect(resumo.motivosMaisComuns.length, 3);
  });

  test('lista vazia deve gerar resumo zerado', () {
    final resumo = calculo.calcular([]);

    expect(resumo.abertos, 0);
    expect(resumo.urgentes, 0);
    expect(resumo.encaminhados, 0);
    expect(resumo.motivosMaisComuns, isEmpty);
  });

  test('casosUrgentes deve retornar só urgentes não resolvidos', () {
    final urgentes = calculo.casosUrgentes(casos);

    expect(urgentes.map((c) => c.id), ['1']);
  });
}
