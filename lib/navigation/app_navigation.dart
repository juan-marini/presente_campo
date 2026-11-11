import 'package:flutter/material.dart';
import 'package:presente_campo/model/caso.dart';
import 'package:presente_campo/navigation/app_routes.dart';
import 'package:presente_campo/ui/screens/caso_detalhe_screen.dart';
import 'package:presente_campo/ui/screens/onboarding_screen.dart';
import 'package:presente_campo/ui/screens/principal_screen.dart';
import 'package:presente_campo/ui/screens/splash_screen.dart';

class AppNavigation {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(
            onIrParaOnboarding: () {
              Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
            },
            onIrParaPrincipal: () {
              Navigator.pushReplacementNamed(context, AppRoutes.principal);
            },
          ),
        );

      case AppRoutes.onboarding:
        return MaterialPageRoute(
          builder: (context) => OnboardingScreen(
            onConcluir: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.principal,
                (route) => false,
              );
            },
          ),
        );

      case AppRoutes.principal:
        return MaterialPageRoute(
          builder: (context) => PrincipalScreen(
            onAbrirCaso: (caso) {
              return Navigator.pushNamed<Caso>(
                context,
                AppRoutes.detalhe,
                arguments: caso,
              );
            },
          ),
        );

      case AppRoutes.detalhe:
        final caso = settings.arguments as Caso?;
        return MaterialPageRoute<Caso>(
          settings: settings,
          builder: (context) => CasoDetalheScreen(
            caso: caso,
            onVoltar: (casoAtualizado) {
              Navigator.pop(context, casoAtualizado);
            },
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Rota não encontrada')),
          ),
        );
    }
  }
}
