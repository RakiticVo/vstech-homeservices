import 'dart:convert';
import 'dart:io';

/// Reads a JSON fixture from `test/fixtures/<path>`.
String fixture(String path) => File('test/fixtures/$path').readAsStringSync();

Map<String, dynamic> jsonFixture(String path) => jsonDecode(fixture(path)) as Map<String, dynamic>;
