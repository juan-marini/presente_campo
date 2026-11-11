import 'package:flutter/material.dart';
import 'package:presente_campo/data/onboarding_data.dart';
import 'package:presente_campo/data/prefs_service.dart';
import 'package:presente_campo/model/onboarding_item.dart';
import 'package:presente_campo/ui/components/onboarding_page.dart';
import 'package:presente_campo/ui/components/pagina_indicador.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onConcluir;

  const OnboardingScreen({super.key, required this.onConcluir});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PrefsService _prefsService = PrefsService();
  final List<OnboardingItem> _itens = getAllOnboardingItems();

  int _paginaAtual = 0;
  bool _naoMostrarNovamente = false;

  bool get _primeiraPagina => _paginaAtual == 0;
  bool get _ultimaPagina => _paginaAtual == _itens.length - 1;

  void _voltar() {
    if (_primeiraPagina) {
      return;
    }
    setState(() {
      _paginaAtual--;
    });
  }

  void _avancar() {
    if (_ultimaPagina) {
      _concluir();
      return;
    }
    setState(() {
      _paginaAtual++;
    });
  }

  Future<void> _concluir() async {
    await _prefsService.salvarOnboardingVisto(_naoMostrarNovamente);
    if (!mounted) {
      return;
    }
    widget.onConcluir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _concluir,
                child: const Text('Pular'),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: OnboardingPage(item: _itens[_paginaAtual]),
                ),
              ),
            ),
            PaginaIndicador(total: _itens.length, atual: _paginaAtual),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: _naoMostrarNovamente,
                onChanged: (value) {
                  setState(() {
                    _naoMostrarNovamente = value ?? false;
                  });
                },
                title: const Text('Não mostrar novamente'),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                children: [
                  OutlinedButton(
                    onPressed: _primeiraPagina ? null : _voltar,
                    child: const Text('Voltar'),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: _avancar,
                    child: Text(_ultimaPagina ? 'Começar' : 'Avançar'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
