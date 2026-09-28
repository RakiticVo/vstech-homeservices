import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vstech_home_services/core/router/app_router.dart';
import 'package:vstech_home_services/core/theme/app_theme.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

/// Baseline device size for `flutter_screenutil` scaling — iPhone 17 Pro logical size
/// (393x852) and responsive viewport 390x844.
const Size _baselineDesignSize = Size(390, 844);

/// Global locale notifier allowing instant language switching (VI / EN) throughout the app.
final ValueNotifier<Locale> appLocaleNotifier = ValueNotifier<Locale>(const Locale('vi'));

class VstechHomeServicesApp extends StatelessWidget {
  const VstechHomeServicesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: appLocaleNotifier,
      builder: (context, currentLocale, _) {
        return ScreenUtilInit(
          designSize: _baselineDesignSize,
          minTextAdapt: true,
          builder: (context, child) => MaterialApp.router(
            title: 'VSTech Home Services',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            routerConfig: appRouter,
            locale: currentLocale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        );
      },
    );
  }
}
