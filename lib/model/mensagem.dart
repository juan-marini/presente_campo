class Mensagem {
  final bool daFamilia;
  final String textoOriginal;
  final String textoPortugues;

  const Mensagem({
    required this.daFamilia,
    required this.textoOriginal,
    required this.textoPortugues,
  });

  factory Mensagem.fromJson(Map<String, dynamic> json) {
    final original = json['texto_original'] ?? '';
    return Mensagem(
      daFamilia: (json['autor'] ?? '') == 'familia',
      textoOriginal: original,
      textoPortugues: json['texto_pt'] ?? original,
    );
  }
}
