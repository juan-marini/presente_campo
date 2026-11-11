import 'package:flutter/material.dart';
import 'package:presente_campo/model/resultado_padrao.dart';

class ResultadoPadraoCard extends StatelessWidget {
  final ResultadoPadrao resultado;
  final bool temPadrao;
  final String turma;
  final String cidade;

  const ResultadoPadraoCard({
    super.key,
    required this.resultado,
    required this.temPadrao,
    required this.turma,
    required this.cidade,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final cor = temPadrao ? colors.error : colors.primary;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(
              temPadrao ? Icons.thunderstorm_outlined : Icons.wb_sunny_outlined,
              size: 48,
              color: cor,
            ),
            const SizedBox(height: 8),
            Text(
              '${resultado.percentual.toStringAsFixed(0)}%',
              style: textTheme.displayMedium?.copyWith(
                color: cor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'das faltas da turma $turma foram em dia de chuva',
              textAlign: TextAlign.center,
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Text(
              '${resultado.faltasComChuva} de ${resultado.faltasComDado} faltas '
              'com dado de clima (chuva ≥ 1 mm em $cidade).',
              textAlign: TextAlign.center,
              style: textTheme.bodySmall,
            ),
            const Divider(height: 32),
            Text(
              temPadrao
                  ? 'A chuva parece afetar a frequência desta turma. '
                      'Vale reforçar o transporte em dias de chuva.'
                  : 'A chuva não parece ser o principal motivo das faltas '
                      'desta turma.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
