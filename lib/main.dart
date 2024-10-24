import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'core/config/app_config.dart';
import 'core/config/app_settings.dart';
import 'core/config/provider_config.dart';
import 'core/config/theme_config.dart';
import 'core/routing/routing.dart';
import 'core/service/navigation_service.dart';

Future<void> main() async =>
    await appConfig.init().then((_) => runApp(const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: ValueListenableBuilder(
        valueListenable: appSettings.settings,
        builder: (_, settings, __) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: settings.themeMode == ThemeMode.light
                  ? Brightness.dark
                  : Brightness.light,
            ),
          );
          return MaterialApp.router(
            title: 'AutoEase',
            debugShowCheckedModeBanner: false,
            scaffoldMessengerKey: navigator.scaffoldMessengerKey,
            themeMode: settings.themeMode,
            theme: theming(ThemeMode.light),
            darkTheme: theming(ThemeMode.dark),
            locale: settings.language.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            builder: (context, child) => ResponsiveBreakpoints.builder(
              child: child!,
              breakpoints: [
                const Breakpoint(start: 0, end: 450, name: MOBILE),
                const Breakpoint(start: 451, end: 800, name: TABLET),
                const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
              ],
            ),
            routerConfig: routing,
          );
        },
      ),
    );
  }
}
