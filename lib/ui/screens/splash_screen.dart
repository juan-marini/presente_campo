import 'package:flutter/material.dart';
import 'package:presente_campo/data/prefs_service.dart';
import 'package:presente_campo/ui/components/app_logo.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onIrParaOnboarding;
  final VoidCallback onIrParaPrincipal;

  const SplashScreen({
    super.key,
    required this.onIrParaOnboarding,
    required this.onIrParaPrincipal,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PrefsService _prefsService = PrefsService();

  @override
  void initState() {
    super.initState();
    _verificarOnboarding();
  }

  Future<void> _verificarOnboarding() async {
    await Future.delayed(const Duration(seconds: 2));
    final visto = await _prefsService.onboardingVisto();

    if (!mounted) {
      return;
    }

    if (visto) {
      widget.onIrParaPrincipal();
    } else {
      widget.onIrParaOnboarding();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppLogo(tamanho: 140),
            const SizedBox(height: 24),
            Text(
              'Presente! Campo',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: colors.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Busca ativa escolar',
              style: TextStyle(color: colors.onPrimary),
            ),
            const SizedBox(height: 32),
            CircularProgressIndicator(color: colors.onPrimary),
          ],
        ),
      ),
    );
  }
}
