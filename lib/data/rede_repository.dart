import 'package:presente_campo/model/motivo.dart';
import 'package:presente_campo/model/servico_rede.dart';
import 'package:presente_campo/model/tipo_servico.dart';

List<ServicoRede> getAllServicos() {
  return const [
    ServicoRede(
      nome: 'CRAS Brás',
      tipo: TipoServico.cras,
      endereco: 'Região do Brás',
      telefone: '156',
      motivosAtendidos: [Motivo.trabalho, Motivo.moradia, Motivo.cuidadoFamiliar],
    ),
    ServicoRede(
      nome: 'CRAS Mooca',
      tipo: TipoServico.cras,
      endereco: 'Região da Mooca',
      telefone: '156',
      motivosAtendidos: [Motivo.moradia, Motivo.trabalho],
    ),
    ServicoRede(
      nome: 'UBS Pari',
      tipo: TipoServico.ubs,
      endereco: 'Região do Pari',
      telefone: '156',
      motivosAtendidos: [Motivo.saude],
    ),
    ServicoRede(
      nome: 'UBS Belém',
      tipo: TipoServico.ubs,
      endereco: 'Região do Belém',
      telefone: '156',
      motivosAtendidos: [Motivo.saude, Motivo.cuidadoFamiliar],
    ),
    ServicoRede(
      nome: 'Conselho Tutelar Sé',
      tipo: TipoServico.conselhoTutelar,
      endereco: 'Região Central',
      telefone: 'Disque 100',
      motivosAtendidos: [Motivo.trabalho, Motivo.outro],
    ),
    ServicoRede(
      nome: 'Passe Livre Estudantil (SPTrans)',
      tipo: TipoServico.transporte,
      endereco: 'Atendimento on-line',
      telefone: '156',
      motivosAtendidos: [Motivo.transporte, Motivo.clima],
    ),
  ];
}

List<ServicoRede> getServicosPor(TipoServico tipo) {
  return getAllServicos().where((servico) => servico.tipo == tipo).toList();
}
