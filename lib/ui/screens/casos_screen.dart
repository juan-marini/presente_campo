import 'package:flutter/material.dart';
import 'package:presente_campo/logic/casos_filtro.dart';
import 'package:presente_campo/model/caso.dart';
import 'package:presente_campo/model/motivo.dart';
import 'package:presente_campo/model/status_caso.dart';
import 'package:presente_campo/model/view_state.dart';
import 'package:presente_campo/ui/components/caso_card.dart';
import 'package:presente_campo/ui/components/estado_view.dart';
import 'package:presente_campo/ui/components/motivo_chip.dart';

class CasosScreen extends StatefulWidget {
  final List<Caso> casos;
  final ViewState estado;
  final String? mensagemErro;
  final Set<String> acompanhando;
  final VoidCallback onAtualizar;
  final Function(Caso) onAbrirCaso;
  final Function(Caso) onAcompanharClick;

  const CasosScreen({
    super.key,
    required this.casos,
    required this.estado,
    required this.mensagemErro,
    required this.acompanhando,
    required this.onAtualizar,
    required this.onAbrirCaso,
    required this.onAcompanharClick,
  });

  @override
  State<CasosScreen> createState() => _CasosScreenState();
}

class _CasosScreenState extends State<CasosScreen> {
  final TextEditingController _buscaController = TextEditingController();
  final CasosFiltro _filtro = CasosFiltro();

  Motivo? _motivoSelecionado;
  StatusCaso? _statusSelecionado;

  @override
  void dispose() {
    _buscaController.dispose();
    super.dispose();
  }

  void _selecionarMotivo(Motivo motivo) {
    setState(() {
      _motivoSelecionado = _motivoSelecionado == motivo ? null : motivo;
    });
  }

  void _limparFiltros() {
    _buscaController.clear();
    setState(() {
      _motivoSelecionado = null;
      _statusSelecionado = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Casos'),
        actions: [
          IconButton(
            onPressed: widget.estado == ViewState.carregando
                ? null
                : widget.onAtualizar,
            icon: const Icon(Icons.refresh),
            tooltip: 'Atualizar',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              controller: _buscaController,
              onChanged: (_) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Buscar aluno pelo nome',
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
                suffixIcon: _buscaController.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          _buscaController.clear();
                          setState(() {});
                        },
                        icon: const Icon(Icons.clear),
                        tooltip: 'Limpar busca',
                      ),
              ),
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: Motivo.values.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final motivo = Motivo.values[index];
                return MotivoChip(
                  motivo: motivo,
                  selecionado: motivo == _motivoSelecionado,
                  onClick: _selecionarMotivo,
                );
              },
            ),
          ),
          Expanded(
            child: EstadoView(
              estado: widget.estado,
              mensagemCarregando: 'Carregando casos...',
              mensagemErro: widget.mensagemErro,
              onTentarNovamente: widget.onAtualizar,
              conteudo: _lista,
            ),
          ),
        ],
      ),
    );
  }

  Widget _lista() {
    final casosFiltrados = _filtro.filtrar(
      casos: widget.casos,
      busca: _buscaController.text,
      motivo: _motivoSelecionado,
      status: _statusSelecionado,
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '${casosFiltrados.length} caso(s)',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              DropdownButton<StatusCaso?>(
                value: _statusSelecionado,
                underline: const SizedBox(),
                items: [
                  const DropdownMenuItem<StatusCaso?>(
                    value: null,
                    child: Text('Todos os status'),
                  ),
                  ...StatusCaso.values.map(
                    (status) => DropdownMenuItem<StatusCaso?>(
                      value: status,
                      child: Text(status.titulo),
                    ),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _statusSelecionado = value;
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: casosFiltrados.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Nenhum caso encontrado'),
                      TextButton(
                        onPressed: _limparFiltros,
                        child: const Text('Limpar filtros'),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  itemCount: casosFiltrados.length,
                  itemBuilder: (context, index) {
                    final caso = casosFiltrados[index];
                    return CasoCard(
                      caso: caso,
                      acompanhando: widget.acompanhando.contains(caso.id),
                      onClick: widget.onAbrirCaso,
                      onAcompanharClick: widget.onAcompanharClick,
                    );
                  },
                ),
        ),
      ],
    );
  }
}
