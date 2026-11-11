enum TipoServico {
  cras,
  ubs,
  conselhoTutelar,
  transporte,
}

extension TipoServicoExtension on TipoServico {
  String get titulo {
    switch (this) {
      case TipoServico.cras:
        return 'CRAS';
      case TipoServico.ubs:
        return 'UBS';
      case TipoServico.conselhoTutelar:
        return 'Conselho Tutelar';
      case TipoServico.transporte:
        return 'Passe Livre';
    }
  }
}

TipoServico tipoServicoFromString(String valor) {
  return TipoServico.values.firstWhere(
    (tipo) => tipo.name == valor,
    orElse: () => TipoServico.cras,
  );
}
