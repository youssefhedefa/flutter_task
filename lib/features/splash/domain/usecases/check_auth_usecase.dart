import  'package:flutter_task/core/networking/storage/domain/secure_storage_service.dart';

class CheckAuthUseCase {
  final SecureStorageService _secureStorageService;

  CheckAuthUseCase({required SecureStorageService secureStorageService})
      : _secureStorageService = secureStorageService;

  Future<bool> execute() async {
    return await _secureStorageService.hasToken();
  }
}

