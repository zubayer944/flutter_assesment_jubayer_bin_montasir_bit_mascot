import 'package:dio/dio.dart' as http;
import '../models/photo_model.dart';
import '../../../../core/network/api_client.dart';

abstract class HomeRemoteDataSource {
  Future<List<PhotoModel>> getPhotos({int page = 1, int limit = 10});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient apiClient;

  HomeRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<PhotoModel>> getPhotos({int page = 1, int limit = 10}) async {
    try {
      final response = await apiClient.get(
        '/photos',
        queryParameters: {'_page': page, '_limit': limit},
      );
      
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