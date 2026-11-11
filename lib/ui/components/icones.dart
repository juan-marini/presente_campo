import 'package:flutter/material.dart';
import 'package:presente_campo/model/motivo.dart';
import 'package:presente_campo/model/tipo_servico.dart';

IconData iconeDoMotivo(Motivo motivo) {
  switch (motivo) {
    case Motivo.transporte:
      return Icons.directions_bus_outlined;
    case Motivo.saude:
      return Icons.local_hospital_outlined;
    case Motivo.trabalho:
      return Icons.work_outline;
    case Motivo.cuidadoFamiliar:
      return Icons.family_restroom;
    case Motivo.clima:
      return Icons.umbrella_outlined;
    case Motivo.moradia:
      return Icons.home_outlined;
    case Motivo.outro:
      return Icons.help_outline;
  }
}

IconData iconeDoServico(TipoServico tipo) {
  switch (tipo) {
    case TipoServico.cras:
      return Icons.diversity_3_outlined;
    case TipoServico.ubs:
      return Icons.medical_services_outlined;
    case TipoServico.conselhoTutelar:
      return Icons.shield_outlined;
    case TipoServico.transporte:
      return Icons.directions_bus_outlined;
  }
}
