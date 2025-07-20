import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password, String name);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await apiClient.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      return UserModel.fromJson(response.data['user']);
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<UserModel> register(String email, String password, String name) async {
    try {
      final response = await apiClient.post('/auth/register', data: {
        'email': email,
        'password': password,
        'name': name,
      });

      return UserModel.fromJson(response.data['user']);
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }
} 