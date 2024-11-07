import 'package:flutter/material.dart';
import 'package:quokka/app_router/app_router.dart';
import 'package:quokka/app_theme/app_theme.dart';

class QuokkaApp extends StatelessWidget {
  final String initialLocation;

  const QuokkaApp({
    super.key,
    required this.initialLocation,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter(initialLocation: initialLocation),
    );
  }
}
