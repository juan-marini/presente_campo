import 'package:flutter/material.dart';
import 'package:presente_campo/logic/painel_calculo.dart';
import 'package:presente_campo/model/caso.dart';
import 'package:presente_campo/model/motivo.dart';
import 'package:presente_campo/model/view_state.dart';
import 'package:presente_campo/ui/components/app_logo.dart';
import 'package:presente_campo/ui/components/caso_card.dart';
import 'package:presente_campo/ui/components/estado_view.dart';
import 'package:presente_campo/ui/components/icones.dart';
import 'package:presente_campo/ui/components/secao_titulo.dart';
import 'package:presente_campo/ui/components/stat_card.dart';

class PainelScreen extends StatelessWidget {
  final List<Caso> casos;
  final ViewState estado;
  final String? mensagemErro;
  final VoidCallback onTentarNovamente;
  final Function(Caso) onAbrirCaso;
  final VoidCallback onVerCasos;

  const PainelScreen({
    super.key,
    required this.casos,
    required this.estado,
    required this.mensagemErro,
    required this.onTentarNovamente,
    required this.onAbrirCaso,
    required this.onVerCasos,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            AppLogo(tamanho: 32),
            SizedBox(width: 12),
            Flexible(
              child: Text('Presente! Campo', overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
      body: EstadoView(
        estado: estado,
        mensagemCarregando: 'Carregando casos...',
        mensagemErro: mensagemErro,
        onTentarNovamente: onTentarNovamente,
        conteudo: () => _conteudo(context),
      ),
    );
  }

  Widget _conteudo(BuildContext context) {
    final calculo = PainelCalculo();
    final resumo = calculo.calcular(casos);
    final urgentes = calculo.casosUrgentes(casos);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Olá, agente!',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const Text('Este é o resumo da busca ativa da sua escola.'),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: StatCard(
                titulo: 'Abertos',
                valor: resumo.abertos,
                icone: Icons.folder_open,
                cor: const Color(0xFFE65100),
              ),
            ),
            Expanded(
              child: StatCard(
                titulo: 'Urgentes',
                valor: resumo.urgentes,
                icone: Icons.priority_high,
                cor: Theme.of(context).colorScheme.error,
              ),
            ),
            Expanded(
              child: StatCard(
                titulo: 'Encaminhados',
                valor: resumo.encaminhados,
                icone: Icons.alt_route,
                cor: const Color(0xFF1565C0),
              ),
            ),
          ],
        ),
        const SecaoTitulo(titulo: 'Motivos mais comuns'),
        Card(
          child: Column(
            children: resumo.motivosMaisComuns
                .map(
                  (entrada) => ListTile(
                    leading: Icon(iconeDoMotivo(entrada.key)),
                    title: Text(entrada.key.titulo),
                    trailing: Text(
                      '${entrada.value}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        SecaoTitulo(
          titulo: 'Casos urgentes',
          acao: TextButton(
            onPressed: onVerCasos,
            child: const Text('Ver todos'),
          ),
        ),
        if (urgentes.isEmpty)
          const Text('Nenhum caso urgente no momento.')
        else
          ...urgentes.map(
            (caso) => CasoCard(caso: caso, onClick: onAbrirCaso),
          ),
      ],
    );
  }
}
