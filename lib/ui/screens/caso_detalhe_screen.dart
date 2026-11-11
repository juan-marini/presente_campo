import 'package:flutter/material.dart';
import 'package:presente_campo/data/caso_repository.dart';
import 'package:presente_campo/data/prefs_service.dart';
import 'package:presente_campo/data/rede_repository.dart';
import 'package:presente_campo/logic/caso_regras.dart';
import 'package:presente_campo/model/caso.dart';
import 'package:presente_campo/model/tipo_servico.dart';
import 'package:presente_campo/ui/components/icones.dart';
import 'package:presente_campo/ui/components/info_card.dart';
import 'package:presente_campo/ui/components/mensagem_bubble.dart';
import 'package:presente_campo/ui/components/motivo_status_linha.dart';
import 'package:presente_campo/ui/components/secao_titulo.dart';

class CasoDetalheScreen extends StatefulWidget {
  final Caso? caso;
  final ValueChanged<Caso?> onVoltar;

  const CasoDetalheScreen({
    super.key,
    required this.caso,
    required this.onVoltar,
  });

  @override
  State<CasoDetalheScreen> createState() => _CasoDetalheScreenState();
}

class _CasoDetalheScreenState extends State<CasoDetalheScreen> {
  final CasoRepository _repository = criarCasoRepository();
  final PrefsService _prefsService = PrefsService();
  final CasoRegras _regras = CasoRegras();

  Caso? _caso;
  bool _acompanhando = false;
  bool _mostrarOriginal = false;
  bool _salvando = false;

  @override
  void initState() {
    super.initState();
    _caso = widget.caso;
    _carregarAcompanhando();
  }

  Future<void> _carregarAcompanhando() async {
    final caso = _caso;
    if (caso == null) {
      return;
    }
    final ids = await _prefsService.favoritos();
    if (!mounted) {
      return;
    }
    setState(() {
      _acompanhando = ids.contains(caso.id);
    });
  }

  Future<void> _alternarAcompanhando() async {
    final caso = _caso!;
    final ids = _regras.alternarFavorito(
      await _prefsService.favoritos(),
      caso.id,
    );
    await _prefsService.salvarFavoritos(ids);
    if (!mounted) {
      return;
    }
    setState(() {
      _acompanhando = ids.contains(caso.id);
    });
    _mostrarMensagem(
      _acompanhando
          ? 'Você está acompanhando este caso.'
          : 'Você deixou de acompanhar este caso.',
    );
  }

  Future<void> _mudarStatus(Caso Function(Caso) regra, String sucesso) async {
    setState(() {
      _salvando = true;
    });

    try {
      final novo = regra(_caso!);
      final salvo = await _repository.atualizarStatus(novo.id, novo.status);
      if (!mounted) {
        return;
      }
      setState(() {
        _caso = salvo;
      });
      _mostrarMensagem(sucesso);
    } catch (erro) {
      if (!mounted) {
        return;
      }
      _mostrarMensagem(erro.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) {
        setState(() {
          _salvando = false;
        });
      }
    }
  }

  void _mostrarMensagem(String texto) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(texto)));
  }

  String _formatarData(DateTime data) {
    final dia = data.day.toString().padLeft(2, '0');
    final mes = data.month.toString().padLeft(2, '0');
    return '$dia/$mes';
  }

  @override
  Widget build(BuildContext context) {
    final caso = _caso;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => widget.onVoltar(_caso),
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Voltar',
        ),
        title: const Text('Detalhe do caso'),
        actions: [
          if (caso != null)
            IconButton(
              onPressed: _alternarAcompanhando,
              tooltip: _acompanhando ? 'Deixar de acompanhar' : 'Acompanhar',
              icon: Icon(
                _acompanhando ? Icons.star : Icons.star_border,
                color: _acompanhando ? Colors.amber.shade700 : null,
              ),
            ),
        ],
      ),
      body: caso == null
          ? const Center(child: Text('Caso não encontrado'))
          : _conteudo(caso),
    );
  }

  Widget _conteudo(Caso caso) {
    final textTheme = Theme.of(context).textTheme;
    final servicos = getServicosPor(caso.encaminhamento);
    final temTraducao = caso.idioma != 'Português';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(caso.aluno, style: textTheme.headlineSmall),
          const SizedBox(height: 4),
          Text(
            '${caso.turma} · Responsável: ${caso.responsavel}',
            style: textTheme.bodyMedium,
          ),
          Text('Idioma da família: ${caso.idioma}', style: textTheme.bodySmall),
          if (caso.urgente) ...[
            const SizedBox(height: 8),
            Text(
              'CASO URGENTE',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
          const SizedBox(height: 12),
          MotivoStatusLinha(motivo: caso.motivo, status: caso.status),
          const SizedBox(height: 16),
          InfoCard(
            icone: Icons.auto_awesome_outlined,
            titulo: 'Resumo da IA',
            conteudo: Text(caso.resumoIa),
          ),
          InfoCard(
            icone: iconeDoServico(caso.encaminhamento),
            titulo: 'Encaminhamento sugerido',
            conteudo: Text(
              servicos.isEmpty
                  ? caso.encaminhamento.titulo
                  : '${caso.encaminhamento.titulo}: ${servicos.first.nome} '
                      '(${servicos.first.telefone})',
            ),
          ),
          InfoCard(
            icone: Icons.event_busy_outlined,
            titulo: '${caso.faltas.length} faltas registradas',
            conteudo: Text(caso.faltas.map(_formatarData).join(' · ')),
          ),
          SecaoTitulo(
            titulo: 'Conversa no WhatsApp',
            acao: temTraducao
                ? TextButton(
                    onPressed: () {
                      setState(() {
                        _mostrarOriginal = !_mostrarOriginal;
                      });
                    },
                    child: Text(
                      _mostrarOriginal ? 'Ver em português' : 'Ver original',
                    ),
                  )
                : null,
          ),
          ...caso.mensagens.map(
            (mensagem) => MensagemBubble(
              mensagem: mensagem,
              mostrarOriginal: _mostrarOriginal,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: !_salvando && _regras.podeEncaminhar(caso)
                  ? () => _mudarStatus(
                        _regras.encaminhar,
                        'Caso encaminhado para ${caso.encaminhamento.titulo}.',
                      )
                  : null,
              child: _salvando
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text('Encaminhar para ${caso.encaminhamento.titulo}'),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: _alternarAcompanhando,
              child: Text(
                _acompanhando ? 'Deixar de acompanhar' : 'Marcar acompanhando',
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: !_salvando && _regras.podeResolver(caso)
                ? () => _mudarStatus(
                      _regras.resolver,
                      'Caso marcado como resolvido.',
                    )
                : null,
            child: const Text('Marcar como resolvido'),
          ),
        ],
      ),
    );
  }
}
