import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthTokenStorageService {
  static const _tokenKey = 'auth_access_token';

  final FlutterSecureStorage _storage;

  const AuthTokenStorageService({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async {
    final token = await _storage.read(key: _tokenKey);
    if (token == null || token.trim().isEmpty) {
      return null;
    }
    return token;
  }

  Future<void> clearToken() async {
    await _storage.delete(key: _tokenKey);
  }
}
