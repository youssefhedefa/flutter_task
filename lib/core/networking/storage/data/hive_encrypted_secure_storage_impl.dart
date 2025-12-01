import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../domain/base_secure_storage.dart';

/// Encrypted Hive implementation of secure storage with AES-256 encryption
/// Data layer - contains framework-specific implementation details
/// Use this for production apps that handle sensitive data
class HiveEncryptedSecureStorageImpl implements BaseSecureStorage {
  static const String _boxName = 'encrypted_secure_storage_box';
  static const String _tokenKey = 'auth_token';

  Box<String>? _box;
  HiveCipher? _encryptionCipher;

  /// Initialize with encryption key
  /// The key should be generated and stored securely (e.g., using device keychain)
  Future<void> init({String? encryptionKey}) async {
    if (encryptionKey != null) {
      // Generate encryption cipher from key
      final key = _generateEncryptionKey(encryptionKey);
      _encryptionCipher = HiveAesCipher(key);
    }
  }

  /// Generate a secure encryption key from a passphrase
  Uint8List _generateEncryptionKey(String passphrase) {
    // Use SHA-256 to generate a 256-bit key
    final bytes = utf8.encode(passphrase);
    final digest = sha256.convert(bytes);
    return Uint8List.fromList(digest.bytes);
  }

  Future<Box<String>> _getBox() async {
    if (_box != null && _box!.isOpen) {
      return _box!;
    }

    if (!Hive.isBoxOpen(_boxName)) {
      // Open box with encryption if cipher is available
      _box = await Hive.openBox<String>(
        _boxName,
        encryptionCipher: _encryptionCipher,
      );
    } else {
      _box = Hive.box<String>(_boxName);
    }

    return _box!;
  }

  @override
  Future<void> saveToken(String token) async {
    await write(_tokenKey, token);
  }

  @override
  Future<String?> getToken() async {
    return await read(_tokenKey);
  }

  @override
  Future<void> deleteToken() async {
    await delete(_tokenKey);
  }

  @override
  Future<void> clearAll() async {
    final box = await _getBox();
    await box.clear();
  }

  @override
  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<void> write(String key, String value) async {
    final box = await _getBox();
    await box.put(key, value);
  }

  @override
  Future<String?> read(String key) async {
    final box = await _getBox();
    return box.get(key);
  }

  @override
  Future<void> delete(String key) async {
    final box = await _getBox();
    await box.delete(key);
  }

  @override
  Future<bool> containsKey(String key) async {
    final box = await _getBox();
    return box.containsKey(key);
  }
}

