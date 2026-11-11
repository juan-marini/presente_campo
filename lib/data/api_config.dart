class ApiConfig {
  ApiConfig._();

  static const String casosBaseUrl = '';

  static const String openMeteoBaseUrl =
      'https://archive-api.open-meteo.com/v1/archive';

  static const String cidadeEscola = 'São Paulo - SP';
  static const double latitudeEscola = -23.55;
  static const double longitudeEscola = -46.63;

  static const Duration tempoLimite = Duration(seconds: 30);
}
