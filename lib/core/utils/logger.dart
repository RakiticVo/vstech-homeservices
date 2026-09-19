import 'package:logger/logger.dart';

/// App-wide logger instance. Use this instead of `print()` anywhere in the codebase.
final Logger appLogger = Logger(
  printer: PrettyPrinter(methodCount: 1, errorMethodCount: 5, printEmojis: false),
);
