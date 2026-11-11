import 'package:flutter/material.dart';
import 'package:presente_campo/model/motivo.dart';
import 'package:presente_campo/model/servico_rede.dart';
import 'package:presente_campo/model/tipo_servico.dart';
import 'package:presente_campo/ui/components/icones.dart';

class ServicoCard extends StatelessWidget {
  final ServicoRede servico;

  const ServicoCard({super.key, required this.servico});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(iconeDoServico(servico.tipo), color: colors.primary),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(servico.nome, style: textTheme.titleMedium),
                    Text(servico.tipo.titulo, style: textTheme.labelMedium),
                    const SizedBox(height: 8),
                    _Linha(icone: Icons.place_outlined, texto: servico.endereco),
                    _Linha(icone: Icons.phone_outlined, texto: servico.telefone),
                    _Linha(
                      icone: Icons.checklist,
                      texto: 'Atende: '
                          '${servico.motivosAtendidos.map((m) => m.titulo).join(', ')}',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Linha extends StatelessWidget {
  final IconData icone;
  final String texto;

  const _Linha({required this.icone, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icone, size: 16),
          const SizedBox(width: 6),
          Expanded(
            child: Text(texto, style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}
