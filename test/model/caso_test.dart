import 'package:flutter_test/flutter_test.dart';
import 'package:presente_campo/model/caso.dart';
import 'package:presente_campo/model/motivo.dart';
import 'package:presente_campo/model/status_caso.dart';
import 'package:presente_campo/model/tipo_servico.dart';

void main() {
  test('fromJson deve converter o JSON da API em um Caso', () {
    final json = <String, dynamic>{
      'id': '42',
      'aluno': 'Ana Souza',
      'turma': '6º A',
      'responsavel': 'Maria Souza',
      'idioma': 'Espanhol',
      'motivo': 'saude',
      'status': 'encaminhado',
      'urgente': true,
      'resumo_ia': 'A aluna está com asma.',
      'encaminhamento': 'ubs',
      'faltas': ['2026-09-01', '2026-09-03'],
      'mensagens': [
        {
          'autor': 'familia',
          'texto_original': 'Mi hija está enferma.',
          'texto_pt': 'Minha filha está doente.',
        },
      ],
    };

    final caso = Caso.fromJson(json);

    expect(caso.id, '42');
    expect(caso.aluno, 'Ana Souza');
    expect(caso.idioma, 'Espanhol');
    expect(caso.motivo, Motivo.saude);
    expect(caso.status, StatusCaso.encaminhado);
    expect(caso.urgente, true);
    expect(caso.encaminhamento, TipoServico.ubs);
    expect(caso.faltas, [DateTime(2026, 9, 1), DateTime(2026, 9, 3)]);
    expect(caso.mensagens.length, 1);
    expect(caso.mensagens.first.daFamilia, true);
    expect(caso.mensagens.first.textoPortugues, 'Minha filha está doente.');
  });

  test('fromJson deve usar valores padrão quando faltam campos', () {
    final caso = Caso.fromJson(<String, dynamic>{'id': 7});

    expect(caso.id, '7');
    expect(caso.aluno, '');
    expect(caso.motivo, Motivo.outro);
    expect(caso.status, StatusCaso.aberto);
    expect(caso.urgente, false);
    expect(caso.faltas, isEmpty);
    expect(caso.mensagens, isEmpty);
  });

  test('motivo desconhecido deve virar "outro"', () {
    final caso = Caso.fromJson(<String, dynamic>{'id': '1', 'motivo': 'xyz'});

    expect(caso.motivo, Motivo.outro);
  });

  test('copyWith deve trocar só o status', () {
    final caso = Caso.fromJson(<String, dynamic>{'id': '1', 'aluno': 'Ana'});

    final copia = caso.copyWith(status: StatusCaso.resolvido);

    expect(copia.status, StatusCaso.resolvido);
    expect(copia.aluno, 'Ana');
    expect(caso.status, StatusCaso.aberto);
  });
}
