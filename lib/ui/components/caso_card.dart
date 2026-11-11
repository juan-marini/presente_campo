import 'package:flutter/material.dart';
import 'package:presente_campo/model/caso.dart';
import 'package:presente_campo/ui/components/motivo_status_linha.dart';

class CasoCard extends StatelessWidget {
  final Caso caso;
  final bool acompanhando;
  final Function(Caso)? onClick;
  final Function(Caso)? onAcompanharClick;

  const CasoCard({
    super.key,
    required this.caso,
    this.acompanhando = false,
    this.onClick,
    this.onAcompanharClick,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onClick != null ? () => onClick!(caso) : null,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 4, 12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (caso.urgente) ...[
                            Icon(
                              Icons.priority_high,
                              size: 18,
                              color: colors.error,
                            ),
                            const SizedBox(width: 4),
                          ],
                          Expanded(
                            child: Text(
                              caso.aluno,
                              style: textTheme.titleMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${caso.turma} · ${caso.idioma} · '
                        '${caso.faltas.length} faltas',
                        style: textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      MotivoStatusLinha(
                        motivo: caso.motivo,
                        status: caso.status,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onAcompanharClick != null
                      ? () => onAcompanharClick!(caso)
                      : null,
                  tooltip: acompanhando ? 'Deixar de acompanhar' : 'Acompanhar',
                  icon: Icon(
                    acompanhando ? Icons.star : Icons.star_border,
                    color: acompanhando ? Colors.amber.shade700 : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
