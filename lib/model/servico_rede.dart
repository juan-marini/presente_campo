import 'package:presente_campo/model/motivo.dart';
import 'package:presente_campo/model/tipo_servico.dart';

class ServicoRede {
  final String nome;
  final TipoServico tipo;
  final String endereco;
  final String telefone;
  final List<Motivo> motivosAtendidos;

  const ServicoRede({
    required this.nome,
    required this.tipo,
    required this.endereco,
    required this.telefone,
    required this.motivosAtendidos,
  });
}
