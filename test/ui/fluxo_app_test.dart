import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:presente_campo/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  Future<void> abrirApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const PresenteCampoApp());
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
  }

  testWidgets('primeira abertura vai da splash para o onboarding',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    await abrirApp(tester);

    expect(find.text('Toda falta tem um motivo'), findsOneWidget);
  });

  testWidgets('com onboarding visto, vai direto para o painel',
      (tester) async {
    SharedPreferences.setMockInitialValues({'onboarding_visto': true});
    await abrirApp(tester);

    expect(find.text('Olá, agente!'), findsOneWidget);
    expect(find.text('Abertos'), findsOneWidget);
    expect(find.text('Motivos mais comuns'), findsOneWidget);
  });

  testWidgets('busca, detalhe, encaminhar e voltar com o status novo',
      (tester) async {
    SharedPreferences.setMockInitialValues({'onboarding_visto': true});
    await abrirApp(tester);

    await tester.tap(find.text('Casos'));
    await tester.pumpAndSettle();
    expect(find.text('8 caso(s)'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'kauã');
    await tester.pump();
    expect(find.text('1 caso(s)'), findsOneWidget);

    await tester.tap(find.text('Kauã Ferreira dos Santos'));
    await tester.pumpAndSettle();
    expect(find.text('Detalhe do caso'), findsOneWidget);
    expect(find.text('Resumo da IA'), findsOneWidget);

    final encaminhar = find.text('Encaminhar para Passe Livre');
    await tester.ensureVisible(encaminhar);
    await tester.tap(encaminhar);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text('ENCAMINHADO'), findsOneWidget);

    await tester.tap(find.byTooltip('Voltar'));
    await tester.pumpAndSettle();
    expect(find.text('Casos'), findsWidgets);
    expect(find.text('ENCAMINHADO'), findsOneWidget);
  });

  testWidgets('voltar pelo botão do sistema também atualiza a lista',
      (tester) async {
    SharedPreferences.setMockInitialValues({'onboarding_visto': true});
    await abrirApp(tester);

    await tester.tap(find.text('Casos'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'sofía');
    await tester.pump();
    await tester.tap(find.text('Sofía Condori Choque'));
    await tester.pumpAndSettle();

    final resolver = find.text('Marcar como resolvido');
    await tester.ensureVisible(resolver);
    await tester.tap(resolver);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    await tester.binding.handlePopRoute();
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.text('RESOLVIDO'), findsOneWidget);
  });

  testWidgets('filtro por motivo e estrela de acompanhar', (tester) async {
    SharedPreferences.setMockInitialValues({'onboarding_visto': true});
    await abrirApp(tester);

    await tester.tap(find.text('Casos'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Saúde').first);
    await tester.pump();
    expect(find.text('2 caso(s)'), findsOneWidget);

    await tester.tap(find.byTooltip('Acompanhar').first);
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.star), findsOneWidget);
  });

  testWidgets('detalhe alterna entre original e português', (tester) async {
    SharedPreferences.setMockInitialValues({'onboarding_visto': true});
    await abrirApp(tester);

    await tester.tap(find.text('Casos'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Woodline Jean-Baptiste'));
    await tester.pumpAndSettle();

    expect(find.text('Minha filha está doente, tem febre e falta de ar.'),
        findsOneWidget);

    final botao = find.text('Ver original');
    await tester.ensureVisible(botao);
    await tester.tap(botao);
    await tester.pump();

    expect(find.text('Pitit fi m malad, li gen lafyèv ak opresyon.'),
        findsOneWidget);
  });

  testWidgets('rede e padrões abrem sem erro (padrões no estado inicial)',
      (tester) async {
    SharedPreferences.setMockInitialValues({'onboarding_visto': true});
    await abrirApp(tester);

    await tester.tap(find.text('Rede'));
    await tester.pumpAndSettle();
    expect(find.text('CRAS Brás'), findsOneWidget);

    await tester.tap(find.text('UBS').first);
    await tester.pump();
    expect(find.text('CRAS Brás'), findsNothing);

    await tester.tap(find.text('Padrões'));
    await tester.pumpAndSettle();
    expect(find.text('Escolha a turma e toque em Analisar.'), findsOneWidget);
  });
}
