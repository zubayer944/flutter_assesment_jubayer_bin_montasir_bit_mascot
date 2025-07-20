import 'package:dio/dio.dart' as http;
import '../models/photo_model.dart';
import '../../../../core/network/api_client.dart';

abstract class HomeRemoteDataSource {
  Future<List<PhotoModel>> getPhotos();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient apiClient;

  HomeRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<PhotoModel>> getPhotos() async {
    try {
      final response = await apiClient.get('/photos');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => PhotoModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load photos');
      }
    } catch (e) {
      throw Exception('Failed to load photos: $e');
    }
  }
} 