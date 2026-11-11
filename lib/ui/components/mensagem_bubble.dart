import 'package:flutter/material.dart';
import 'package:presente_campo/model/mensagem.dart';

class MensagemBubble extends StatelessWidget {
  final Mensagem mensagem;
  final bool mostrarOriginal;

  const MensagemBubble({
    super.key,
    required this.mensagem,
    required this.mostrarOriginal,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final daFamilia = mensagem.daFamilia;
    final texto =
        mostrarOriginal ? mensagem.textoOriginal : mensagem.textoPortugues;

    return Align(
      alignment: daFamilia ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: daFamilia
              ? colors.surfaceContainerHighest
              : colors.primaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              daFamilia ? 'Família' : 'Bot Presente!',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(texto),
          ],
        ),
      ),
    );
  }
}
