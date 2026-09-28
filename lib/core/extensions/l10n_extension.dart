import 'package:flutter/widgets.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

/// Convenient extension on [BuildContext] to access localized strings cleanly:
/// `context.l10n.skip`, `context.l10n.appName`, etc.
extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
