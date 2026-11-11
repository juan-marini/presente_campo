import 'package:flutter_test/flutter_test.dart';
import 'package:presente_campo/model/clima_dia.dart';

void main() {
  test('listaFromJson deve ler o formato da Open-Meteo', () {
    final json = <String, dynamic>{
      'daily': {
        'time': ['2026-09-01', '2026-09-02'],
        'precipitation_sum': [22.7, 0],
      },
    };

    final dias = ClimaDia.listaFromJson(json);

    expect(dias.length, 2);
    expect(dias[0].data, DateTime(2026, 9, 1));
    expect(dias[0].precipitacaoMm, closeTo(22.7, 0.01));
    expect(dias[1].precipitacaoMm, closeTo(0.0, 0.01));
  });

  test('dia com precipitação nula deve ser ignorado', () {
    final json = <String, dynamic>{
      'daily': {
        'time': ['2026-09-01', '2026-09-02'],
        'precipitation_sum': [null, 3.5],
      },
    };

    final dias = ClimaDia.listaFromJson(json);

    expect(dias.length, 1);
    expect(dias.first.data, DateTime(2026, 9, 2));
  });

  test('JSON sem "daily" deve retornar lista vazia', () {
    expect(ClimaDia.listaFromJson(<String, dynamic>{}), isEmpty);
  });
}
