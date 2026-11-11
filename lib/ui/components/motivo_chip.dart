import 'package:flutter/material.dart';
import 'package:presente_campo/model/motivo.dart';
import 'package:presente_campo/ui/components/filtro_chip.dart';
import 'package:presente_campo/ui/components/icones.dart';

class MotivoChip extends StatelessWidget {
  final Motivo motivo;
  final bool selecionado;
  final Function(Motivo)? onClick;

  const MotivoChip({
    super.key,
    required this.motivo,
    this.selecionado = false,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return FiltroChip(
      texto: motivo.titulo,
      icone: iconeDoMotivo(motivo),
      selecionado: selecionado,
      onClick: onClick != null ? () => onClick!(motivo) : null,
    );
  }
}
