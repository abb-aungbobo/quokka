import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quokka/secure_storage/secure_storage_key.dart';

class SecureStorage {
  final _secureStorage = const FlutterSecureStorage();

  void write({
    required String value,
    required SecureStorageKey key,
  }) async {
    await _secureStorage.write(key: key.rawValue, value: value);
  }

  Future<String?> read({required SecureStorageKey key}) async {
    return await _secureStorage.read(key: key.rawValue);
  }

  void deleteAll() {
    _secureStorage.deleteAll();
  }
}
