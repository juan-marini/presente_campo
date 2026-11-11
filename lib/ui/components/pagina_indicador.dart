import 'package:flutter/material.dart';

class PaginaIndicador extends StatelessWidget {
  final int total;
  final int atual;

  const PaginaIndicador({super.key, required this.total, required this.atual});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (index) {
        final ativo = index == atual;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: ativo ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: ativo ? colors.primary : colors.outlineVariant,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
