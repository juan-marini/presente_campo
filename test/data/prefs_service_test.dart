import 'package:flutter_test/flutter_test.dart';
import 'package:presente_campo/data/prefs_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final prefsService = PrefsService();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('sem nada salvo, o onboarding não foi visto', () async {
    expect(await prefsService.onboardingVisto(), false);
  });

  test('marcar "não mostrar novamente" deve salvar true', () async {
    await prefsService.salvarOnboardingVisto(true);

    expect(await prefsService.onboardingVisto(), true);
  });

  test('concluir sem marcar deve manter o onboarding visível', () async {
    await prefsService.salvarOnboardingVisto(false);

    expect(await prefsService.onboardingVisto(), false);
  });

  test('favoritos devem ser salvos e lidos', () async {
    await prefsService.salvarFavoritos({'1', '3'});

    expect(await prefsService.favoritos(), {'1', '3'});
  });

  test('sem favoritos salvos deve retornar conjunto vazio', () async {
    expect(await prefsService.favoritos(), isEmpty);
  });
}
