import 'package:flutter/material.dart';
import 'package:presente_campo/model/motivo.dart';
import 'package:presente_campo/model/status_caso.dart';
import 'package:presente_campo/ui/components/icones.dart';
import 'package:presente_campo/ui/components/status_badge.dart';

class MotivoStatusLinha extends StatelessWidget {
  final Motivo motivo;
  final StatusCaso status;

  const MotivoStatusLinha({
    super.key,
    required this.motivo,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(iconeDoMotivo(motivo), size: 18, color: colors.primary),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            motivo.titulo,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: colors.primary, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(width: 8),
        StatusBadge(status: status),
      ],
    );
  }
}
