import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final Widget conteudo;

  const InfoCard({
    super.key,
    required this.icone,
    required this.titulo,
    required this.conteudo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icone, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    titulo,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            conteudo,
          ],
        ),
      ),
    );
  }
}
