import 'package:presente_campo/model/caso.dart';
import 'package:presente_campo/model/motivo.dart';
import 'package:presente_campo/model/status_caso.dart';
import 'package:presente_campo/model/tipo_servico.dart';

Caso criarCasoTeste({
  String id = '1',
  String aluno = 'Ana Souza',
  String turma = '6º A',
  Motivo motivo = Motivo.transporte,
  StatusCaso status = StatusCaso.aberto,
  bool urgente = false,
  List<DateTime> faltas = const [],
}) {
  return Caso(
    id: id,
    aluno: aluno,
    turma: turma,
    responsavel: 'Responsável',
    idioma: 'Português',
    motivo: motivo,
    status: status,
    urgente: urgente,
    resumoIa: 'Resumo',
    encaminhamento: TipoServico.cras,
    faltas: faltas,
    mensagens: const [],
  );
}
