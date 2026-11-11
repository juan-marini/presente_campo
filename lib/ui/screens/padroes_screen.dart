import 'package:flutter/material.dart';
import 'package:presente_campo/data/api_config.dart';
import 'package:presente_campo/data/clima_service.dart';
import 'package:presente_campo/logic/analisador_padroes.dart';
import 'package:presente_campo/model/caso.dart';
import 'package:presente_campo/model/resultado_padrao.dart';
import 'package:presente_campo/model/view_state.dart';
import 'package:presente_campo/ui/components/estado_view.dart';
import 'package:presente_campo/ui/components/resultado_padrao_card.dart';

class PadroesScreen extends StatefulWidget {
  final List<Caso> casos;

  const PadroesScreen({super.key, required this.casos});

  @override
  State<PadroesScreen> createState() => _PadroesScreenState();
}

class _PadroesScreenState extends State<PadroesScreen> {
  final ClimaService _climaService = ClimaService();
  final AnalisadorPadroes _analisador = AnalisadorPadroes();

  String? _turmaSelecionada;
  ViewState _estado = ViewState.inicial;
  ResultadoPadrao? _resultado;
  String? _mensagemErro;

  Future<void> _analisar() async {
    final turma = _turmaSelecionada;
    if (turma == null) {
      return;
    }

    final faltas = _analisador.faltasDaTurma(widget.casos, turma);
    if (faltas.isEmpty) {
      setState(() {
        _estado = ViewState.erro;
        _mensagemErro = 'A turma $turma não tem faltas registradas.';
      });
      return;
    }

    setState(() {
      _estado = ViewState.carregando;
      _mensagemErro = null;
    });

    try {
      final dias = await _climaService.buscarChuva(
        inicio: _analisador.primeiraData(faltas),
        fim: _analisador.ultimaData(faltas),
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _resultado = _analisador.analisar(faltas: faltas, climaDias: dias);
        _estado = ViewState.sucesso;
      });
    } catch (erro) {
      if (!mounted) {
        return;
      }
      setState(() {
        _mensagemErro = erro.toString().replaceFirst('Exception: ', '');
        _estado = ViewState.erro;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final turmas = _analisador.turmas(widget.casos);

    return Scaffold(
      appBar: AppBar(title: const Text('Padrões de falta')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Descubra se as faltas de uma turma acontecem mais em dias '
                  'de chuva. Os dados de clima vêm da API pública Open-Meteo.',
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _turmaSelecionada,
                  decoration: const InputDecoration(
                    labelText: 'Turma',
                    border: OutlineInputBorder(),
                  ),
                  hint: Text(
                    turmas.isEmpty
                        ? 'Nenhuma turma carregada'
                        : 'Escolha a turma',
                  ),
                  items: turmas
                      .map(
                        (turma) => DropdownMenuItem<String>(
                          value: turma,
                          child: Text(turma),
                        ),
                      )
                      .toList(),
                  onChanged: _estado == ViewState.carregando
                      ? null
                      : (value) {
                          setState(() {
                            _turmaSelecionada = value;
                            _estado = ViewState.inicial;
                            _resultado = null;
                          });
                        },
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _turmaSelecionada == null ||
                            _estado == ViewState.carregando
                        ? null
                        : _analisar,
                    child: const Text('Analisar'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: EstadoView(
              estado: _estado,
              mensagemInicial: 'Escolha a turma e toque em Analisar.',
              mensagemCarregando: 'Consultando a chuva na Open-Meteo...',
              mensagemErro: _mensagemErro,
              onTentarNovamente: _turmaSelecionada == null ? null : _analisar,
              conteudo: () => SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: ResultadoPadraoCard(
                  resultado: _resultado!,
                  temPadrao: _analisador.temPadraoDeChuva(_resultado!),
                  turma: _turmaSelecionada ?? '',
                  cidade: ApiConfig.cidadeEscola,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
