import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String titulo;
  final int valor;
  final IconData icone;
  final Color cor;

  const StatCard({
    super.key,
    required this.titulo,
    required this.valor,
    required this.icone,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: [
            Icon(icone, color: cor),
            const SizedBox(height: 8),
            Text(
              '$valor',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: cor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              titulo,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
