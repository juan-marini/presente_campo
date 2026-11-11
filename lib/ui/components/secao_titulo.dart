import 'package:flutter/material.dart';

class SecaoTitulo extends StatelessWidget {
  final String titulo;
  final Widget? acao;

  const SecaoTitulo({super.key, required this.titulo, this.acao});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              titulo,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          ?acao,
        ],
      ),
    );
  }
}
