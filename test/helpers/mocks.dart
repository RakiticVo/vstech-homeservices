import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/network/auth_token_store.dart';

class MockAuthTokenStore extends Mock implements AuthTokenStore;

class MockHttpClientAdapter extends Mock implements HttpClientAdapter;

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage;
