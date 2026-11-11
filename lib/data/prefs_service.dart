import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static const String chaveOnboardingVisto = 'onboarding_visto';
  static const String chaveFavoritos = 'casos_acompanhando';

  Future<bool> onboardingVisto() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(chaveOnboardingVisto) ?? false;
  }

  Future<void> salvarOnboardingVisto(bool visto) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(chaveOnboardingVisto, visto);
  }

  Future<Set<String>> favoritos() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(chaveFavoritos) ?? []).toSet();
  }

  Future<void> salvarFavoritos(Set<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(chaveFavoritos, ids.toList());
  }
}
