import 'package:flutter/material.dart';
import 'package:presente_campo/data/caso_repository.dart';
import 'package:presente_campo/data/prefs_service.dart';
import 'package:presente_campo/logic/caso_regras.dart';
import 'package:presente_campo/model/caso.dart';
import 'package:presente_campo/model/view_state.dart';
import 'package:presente_campo/ui/screens/casos_screen.dart';
import 'package:presente_campo/ui/screens/padroes_screen.dart';
import 'package:presente_campo/ui/screens/painel_screen.dart';
import 'package:presente_campo/ui/screens/rede_screen.dart';

class PrincipalScreen extends StatefulWidget {
  final Future<Caso?> Function(Caso) onAbrirCaso;

  const PrincipalScreen({super.key, required this.onAbrirCaso});

  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  final CasoRepository _repository = criarCasoRepository();
  final PrefsService _prefsService = PrefsService();
  final CasoRegras _regras = CasoRegras();

  int _abaAtual = 0;
  List<Caso> _casos = [];
  ViewState _estado = ViewState.inicial;
  String? _mensagemErro;
  Set<String> _acompanhando = {};

  @override
  void initState() {
    super.initState();
    _carregarCasos();
    _carregarAcompanhando();
  }

  Future<void> _carregarCasos() async {
    setState(() {
      _estado = ViewState.carregando;
      _mensagemErro = null;
    });

    try {
      final casos = await _repository.buscarCasos();
      if (!mounted) {
        return;
      }
      setState(() {
        _casos = casos;
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

  Future<void> _carregarAcompanhando() async {
    final ids = await _prefsService.favoritos();
    if (!mounted) {
      return;
    }
    setState(() {
      _acompanhando = ids;
    });
  }

  Future<void> _alternarAcompanhando(Caso caso) async {
    final novos = _regras.alternarFavorito(_acompanhando, caso.id);
    setState(() {
      _acompanhando = novos;
    });
    await _prefsService.salvarFavoritos(novos);
  }

  Future<void> _abrirCaso(Caso caso) async {
    final atualizado = await widget.onAbrirCaso(caso);
    if (!mounted) {
      return;
    }
    if (atualizado != null) {
      setState(() {
        _casos = _casos
            .map((c) => c.id == atualizado.id ? atualizado : c)
            .toList();
      });
    } else {
      await _sincronizarCasos();
    }
    await _carregarAcompanhando();
  }

  Future<void> _sincronizarCasos() async {
    try {
      final casos = await _repository.buscarCasos();
      if (!mounted) {
        return;
      }
      setState(() {
        _casos = casos;
      });
    } catch (_) {
    }
  }

  Widget _abaSelecionada() {
    switch (_abaAtual) {
      case 0:
        return PainelScreen(
          casos: _casos,
          estado: _estado,
          mensagemErro: _mensagemErro,
          onTentarNovamente: _carregarCasos,
          onAbrirCaso: _abrirCaso,
          onVerCasos: () {
            setState(() {
              _abaAtual = 1;
            });
          },
        );
      case 1:
        return CasosScreen(
          casos: _casos,
          estado: _estado,
          mensagemErro: _mensagemErro,
          acompanhando: _acompanhando,
          onAtualizar: _carregarCasos,
          onAbrirCaso: _abrirCaso,
          onAcompanharClick: _alternarAcompanhando,
        );
      case 2:
        return const RedeScreen();
      default:
        return PadroesScreen(casos: _casos);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _abaSelecionada(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _abaAtual,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _abaAtual = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Painel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_shared_outlined),
            label: 'Casos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hub_outlined),
            label: 'Rede',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insights_outlined),
            label: 'Padrões',
          ),
        ],
      ),
    );
  }
}
