import 'package:flutter/material.dart';
import 'package:quokka/app/quokka_app.dart';
import 'package:quokka/app_router/app_router.dart';
import 'package:quokka/locator/locator.dart';
import 'package:quokka/secure_storage/secure_storage.dart';
import 'package:quokka/secure_storage/secure_storage_key.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  final secureStorage = locator<SecureStorage>();
  final userToken = await secureStorage.read(key: SecureStorageKey.userToken);
  final initialLocation = userToken == null ? RoutePath.login : RoutePath.qotd;
  runApp(
    QuokkaApp(
      initialLocation: initialLocation,
    ),
  );
}
