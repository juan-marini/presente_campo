enum Motivo {
  transporte,
  saude,
  trabalho,
  cuidadoFamiliar,
  clima,
  moradia,
  outro,
}

extension MotivoExtension on Motivo {
  String get titulo {
    switch (this) {
      case Motivo.transporte:
        return 'Transporte';
      case Motivo.saude:
        return 'Saúde';
      case Motivo.trabalho:
        return 'Trabalho';
      case Motivo.cuidadoFamiliar:
        return 'Cuidado familiar';
      case Motivo.clima:
        return 'Clima';
      case Motivo.moradia:
        return 'Moradia';
      case Motivo.outro:
        return 'Outro';
    }
  }
}

Motivo motivoFromString(String valor) {
  return Motivo.values.firstWhere(
    (motivo) => motivo.name == valor,
    orElse: () => Motivo.outro,
  );
}
