import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:presente_campo/data/prefs_service.dart';
import 'package:presente_campo/ui/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  Future<void> irAteOFim(WidgetTester tester) async {
    for (var i = 0; i < 3; i++) {
      await tester.tap(find.text('Avançar'));
      await tester.pump();
    }
    expect(find.text('Começar'), findsOneWidget);
  }

  testWidgets('Voltar começa desabilitado e funciona depois de avançar',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: OnboardingScreen(onConcluir: () {})),
    );

    final voltar = find.widgetWithText(OutlinedButton, 'Voltar');
    expect(tester.widget<OutlinedButton>(voltar).onPressed, isNull);

    await tester.tap(find.text('Avançar'));
    await tester.pump();
    expect(find.text('Conversa no WhatsApp, em qualquer língua'),
        findsOneWidget);

    await tester.tap(voltar);
    await tester.pump();
    expect(find.text('Toda falta tem um motivo'), findsOneWidget);
  });

  testWidgets('concluir sem marcar a opção mantém o onboarding',
      (tester) async {
    var concluiu = false;
    await tester.pumpWidget(
      MaterialApp(home: OnboardingScreen(onConcluir: () => concluiu = true)),
    );

    await irAteOFim(tester);
    await tester.tap(find.text('Começar'));
    await tester.pumpAndSettle();

    expect(concluiu, true);
    expect(await PrefsService().onboardingVisto(), false);
  });

  testWidgets('marcar "Não mostrar novamente" salva a preferência',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: OnboardingScreen(onConcluir: () {})),
    );

    await tester.tap(find.text('Não mostrar novamente'));
    await tester.pump();
    await irAteOFim(tester);
    await tester.tap(find.text('Começar'));
    await tester.pumpAndSettle();

    expect(await PrefsService().onboardingVisto(), true);
  });
}
