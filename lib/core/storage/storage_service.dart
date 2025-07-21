import 'package:get_storage/get_storage.dart';

abstract class StorageService {
  Future<void> init();
  Future<void> write(String key, dynamic value);
  T? read<T>(String key);
  Future<void> remove(String key);
  Future<void> clear();
  bool hasData(String key);
}

class StorageServiceImpl implements StorageService {
  late GetStorage _storage;

  @override
  Future<void> init() async {
    _storage = GetStorage();
  }

  @override
  Future<void> write(String key, dynamic value) async {
    await _storage.write(key, value);
  }

  @override
  T? read<T>(String key) {
    return _storage.read<T>(key);
  }

  @override
  Future<void> remove(String key) async {
    await _storage.remove(key);
  }

  @override
  Future<void> clear() async {
    await _storage.erase();
  }

  @override
  bool hasData(String key) {
    return _storage.hasData(key);
  }
} 