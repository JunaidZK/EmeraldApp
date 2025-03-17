import 'package:emerald_beauty/app_init/app_init.dart';
import 'package:emerald_beauty/globals.dart';
import 'package:emerald_beauty/localization/app_localization.dart';
import 'package:emerald_beauty/localization/localization_provider.dart';
import 'package:emerald_beauty/routes/apps_routes.dart';
import 'package:emerald_beauty/themes/app_theme.dart';
import 'package:emerald_beauty/views/auth/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

void main() {
  AppInit.initializeApp();
  final localeProvider = LocaleProvider();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => localeProvider),
        ChangeNotifierProvider(create: (_) => GlobalProvider()),
        // Add more providers here if needed
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return Consumer<LocaleProvider>(
          builder: (context, localeProvider, child) {
        return GetMaterialApp(
          title: "Emerald Beauty",
          debugShowCheckedModeBanner: false,
          theme: AppThemes.lightTheme,
          routes: AppsRoutes.routes,
          locale: localeProvider.locale, // Use the locale from the provider
          localizationsDelegates: const [
            AppLocalizations.delegate, // Your AppLocalizations delegate
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('ar'), // Arabic
          ],
          home: const SplashView(),
        );
      });
    });
  }
}
