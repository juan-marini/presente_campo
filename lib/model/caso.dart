import 'package:equatable/equatable.dart';
import 'package:presente_campo/model/mensagem.dart';
import 'package:presente_campo/model/motivo.dart';
import 'package:presente_campo/model/status_caso.dart';
import 'package:presente_campo/model/tipo_servico.dart';

class Caso extends Equatable {
  final String id;
  final String aluno;
  final String turma;
  final String responsavel;
  final String idioma;
  final Motivo motivo;
  final StatusCaso status;
  final bool urgente;
  final String resumoIa;
  final TipoServico encaminhamento;
  final List<DateTime> faltas;
  final List<Mensagem> mensagens;

  const Caso({
    required this.id,
    required this.aluno,
    required this.turma,
    required this.responsavel,
    required this.idioma,
    required this.motivo,
    required this.status,
    required this.urgente,
    required this.resumoIa,
    required this.encaminhamento,
    required this.faltas,
    required this.mensagens,
  });

  factory Caso.fromJson(Map<String, dynamic> json) {
    final faltasJson = json['faltas'] as List<dynamic>? ?? [];
    final mensagensJson = json['mensagens'] as List<dynamic>? ?? [];

    return Caso(
      id: (json['id'] ?? '').toString(),
      aluno: json['aluno'] ?? '',
      turma: json['turma'] ?? '',
      responsavel: json['responsavel'] ?? '',
      idioma: json['idioma'] ?? 'Português',
      motivo: motivoFromString(json['motivo'] ?? ''),
      status: statusFromString(json['status'] ?? ''),
      urgente: json['urgente'] ?? false,
      resumoIa: json['resumo_ia'] ?? '',
      encaminhamento: tipoServicoFromString(json['encaminhamento'] ?? ''),
      faltas: faltasJson.map((data) => DateTime.parse(data as String)).toList(),
      mensagens: mensagensJson
          .map((m) => Mensagem.fromJson(m as Map<String, dynamic>))
          .toList(),
    );
  }

  Caso copyWith({StatusCaso? status}) {
    return Caso(
      id: id,
      aluno: aluno,
      turma: turma,
      responsavel: responsavel,
      idioma: idioma,
      motivo: motivo,
      status: status ?? this.status,
      urgente: urgente,
      resumoIa: resumoIa,
      encaminhamento: encaminhamento,
      faltas: faltas,
      mensagens: mensagens,
    );
  }

  @override
  List<Object?> get props => [id, aluno, turma, motivo, status, urgente];
}
