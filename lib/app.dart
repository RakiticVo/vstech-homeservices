import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:vstech_home_services/core/router/app_router.dart';
import 'package:vstech_home_services/core/theme/app_theme.dart';

/// Baseline device size for `flutter_screenutil` scaling — iPhone 17 Pro logical size
/// (393x852), per CLAUDE.md Design System / Responsive rules.
const Size _baselineDesignSize = Size(393, 852);

class VstechHomeServicesApp extends StatelessWidget {
  const VstechHomeServicesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: _baselineDesignSize,
      minTextAdapt: true,
      builder: (context, child) => MaterialApp.router(
        title: 'VSTech Home Services',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        routerConfig: appRouter,
      ),
    );
  }
}
