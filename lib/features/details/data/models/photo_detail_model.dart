import '../../domain/entities/photo_detail.dart';

class PhotoDetailModel extends PhotoDetail {
  PhotoDetailModel({
    required super.albumId,
    required super.id,
    required super.title,
    required super.url,
    required super.thumbnailUrl,
  });

  factory PhotoDetailModel.fromJson(Map<String, dynamic> json) {
    return PhotoDetailModel(
      albumId: json['albumId'] ?? 0,
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      url: json['url'] ?? '',
      thumbnailUrl: json['thumbnailUrl'] ?? '',
    );
  }
} 