import 'package:flutter/material.dart';
import 'package:presente_campo/model/view_state.dart';

class EstadoView extends StatelessWidget {
  final ViewState estado;
  final Widget Function() conteudo;
  final String mensagemInicial;
  final String mensagemCarregando;
  final String? mensagemErro;
  final VoidCallback? onTentarNovamente;

  const EstadoView({
    super.key,
    required this.estado,
    required this.conteudo,
    this.mensagemInicial = '',
    this.mensagemCarregando = 'Carregando...',
    this.mensagemErro,
    this.onTentarNovamente,
  });

  @override
  Widget build(BuildContext context) {
    switch (estado) {
      case ViewState.inicial:
        return _Mensagem(
          icone: Icons.touch_app_outlined,
          texto: mensagemInicial,
        );
      case ViewState.carregando:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(mensagemCarregando),
            ],
          ),
        );
      case ViewState.erro:
        return _ErroCard(
          mensagem: mensagemErro ?? 'Algo deu errado.',
          onTentarNovamente: onTentarNovamente,
        );
      case ViewState.sucesso:
        return conteudo();
    }
  }
}

class _Mensagem extends StatelessWidget {
  final IconData icone;
  final String texto;

  const _Mensagem({required this.icone, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icone,
              size: 56,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 12),
            Text(
              texto,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class _ErroCard extends StatelessWidget {
  final String mensagem;
  final VoidCallback? onTentarNovamente;

  const _ErroCard({required this.mensagem, this.onTentarNovamente});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Card(
          color: colorScheme.errorContainer,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.cloud_off_outlined,
                  size: 40,
                  color: colorScheme.onErrorContainer,
                ),
                const SizedBox(height: 12),
                Text(
                  mensagem,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colorScheme.onErrorContainer),
                ),
                if (onTentarNovamente != null) ...[
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: onTentarNovamente,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Tentar novamente'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
