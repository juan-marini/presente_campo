import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:presente_campo/app_theme.dart';
import 'package:presente_campo/navigation/app_navigation.dart';
import 'package:presente_campo/navigation/app_routes.dart';

void main() {
  runApp(const PresenteCampoApp());
}

class PresenteCampoApp extends StatelessWidget {
  const PresenteCampoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Presente! Campo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      scrollBehavior: MouseScrollBehavior(),
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppNavigation.generateRoute,
    );
  }
}

class MouseScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}
