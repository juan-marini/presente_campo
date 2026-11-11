import 'package:flutter/material.dart';

class FiltroChip extends StatelessWidget {
  final String texto;
  final IconData icone;
  final bool selecionado;
  final VoidCallback? onClick;

  const FiltroChip({
    super.key,
    required this.texto,
    required this.icone,
    this.selecionado = false,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final corTexto =
        selecionado ? colors.onPrimary : colors.onSecondaryContainer;

    return GestureDetector(
      onTap: onClick,
      child: Chip(
        backgroundColor:
            selecionado ? colors.primary : colors.secondaryContainer,
        side: BorderSide.none,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icone, size: 16, color: corTexto),
            const SizedBox(width: 6),
            Text(texto, style: TextStyle(color: corTexto)),
          ],
        ),
      ),
    );
  }
}
