import 'package:flutter/material.dart';
import 'package:presente_campo/data/rede_repository.dart';
import 'package:presente_campo/model/servico_rede.dart';
import 'package:presente_campo/model/tipo_servico.dart';
import 'package:presente_campo/ui/components/filtro_chip.dart';
import 'package:presente_campo/ui/components/icones.dart';
import 'package:presente_campo/ui/components/servico_card.dart';

class RedeScreen extends StatefulWidget {
  const RedeScreen({super.key});

  @override
  State<RedeScreen> createState() => _RedeScreenState();
}

class _RedeScreenState extends State<RedeScreen> {
  TipoServico? _tipoSelecionado;
  late List<ServicoRede> _servicos;

  @override
  void initState() {
    super.initState();
    _servicos = getAllServicos();
  }

  void _selecionarTipo(TipoServico tipo) {
    setState(() {
      if (_tipoSelecionado == tipo) {
        _tipoSelecionado = null;
        _servicos = getAllServicos();
      } else {
        _tipoSelecionado = tipo;
        _servicos = getServicosPor(tipo);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rede de apoio')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              'Serviços para onde os casos podem ser encaminhados '
              '(dados de demonstração).',
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: TipoServico.values.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final tipo = TipoServico.values[index];
                return FiltroChip(
                  texto: tipo.titulo,
                  icone: iconeDoServico(tipo),
                  selecionado: tipo == _tipoSelecionado,
                  onClick: () => _selecionarTipo(tipo),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _servicos.length,
              itemBuilder: (context, index) {
                return ServicoCard(servico: _servicos[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
