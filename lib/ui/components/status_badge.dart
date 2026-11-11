import 'package:flutter/material.dart';
import 'package:presente_campo/model/status_caso.dart';

class StatusBadge extends StatelessWidget {
  final StatusCaso status;

  const StatusBadge({super.key, required this.status});

  Color _cor() {
    switch (status) {
      case StatusCaso.aberto:
        return const Color(0xFFE65100);
      case StatusCaso.encaminhado:
        return const Color(0xFF1565C0);
      case StatusCaso.resolvido:
        return const Color(0xFF2E7D32);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cor = _cor();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: cor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cor),
      ),
      child: Text(
        status.titulo.toUpperCase(),
        style: TextStyle(
          color: cor,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
