class ClimaDia {
  final DateTime data;
  final double precipitacaoMm;

  const ClimaDia({required this.data, required this.precipitacaoMm});

  static List<ClimaDia> listaFromJson(Map<String, dynamic> json) {
    final daily = json['daily'] as Map<String, dynamic>?;
    if (daily == null) {
      return [];
    }

    final datas = daily['time'] as List<dynamic>? ?? [];
    final chuvas = daily['precipitation_sum'] as List<dynamic>? ?? [];
    final dias = <ClimaDia>[];

    for (var i = 0; i < datas.length && i < chuvas.length; i++) {
      final chuva = chuvas[i];
      if (chuva == null) {
        continue;
      }
      dias.add(
        ClimaDia(
          data: DateTime.parse(datas[i] as String),
          precipitacaoMm: (chuva as num).toDouble(),
        ),
      );
    }

    return dias;
  }
}
