enum StatusCaso {
  aberto,
  encaminhado,
  resolvido,
}

extension StatusCasoExtension on StatusCaso {
  String get titulo {
    switch (this) {
      case StatusCaso.aberto:
        return 'Aberto';
      case StatusCaso.encaminhado:
        return 'Encaminhado';
      case StatusCaso.resolvido:
        return 'Resolvido';
    }
  }
}

StatusCaso statusFromString(String valor) {
  return StatusCaso.values.firstWhere(
    (status) => status.name == valor,
    orElse: () => StatusCaso.aberto,
  );
}
