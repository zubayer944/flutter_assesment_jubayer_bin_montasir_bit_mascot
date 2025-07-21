import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../../features/home/domain/entities/photo.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorites';
  static final GetStorage _storage = GetStorage();
  
  // Get all favorites
  static Future<List<Photo>> getFavorites() async {
    final rawList = _storage.read(_favoritesKey);
    final favoritesJson = (rawList as List?)?.map((e) => e.toString()).toList() ?? [];
    return favoritesJson
        .map((json) => Photo.fromJson(jsonDecode(json)))
        .toList();
  }
  
  // Add to favorites
  static Future<bool> addToFavorites(Photo photo) async {
    final favorites = await getFavorites();
    
    // Check if already in favorites
    if (favorites.any((fav) => fav.id == photo.id)) {
      return false; // Already in favorites
    }
    
    favorites.add(photo);
    final favoritesJson = favorites
        .map((photo) => jsonEncode(photo.toJson()))
        .toList();
    
    _storage.write(_favoritesKey, favoritesJson);
    return true;
  }
  
  // Remove from favorites
  static Future<bool> removeFromFavorites(int photoId) async {
    final favorites = await getFavorites();
    
    favorites.removeWhere((photo) => photo.id == photoId);
    final favoritesJson = favorites
        .map((photo) => jsonEncode(photo.toJson()))
        .toList();
    
    _storage.write(_favoritesKey, favoritesJson);
    return true;
  }
  
  // Check if photo is in favorites
  static Future<bool> isFavorite(int photoId) async {
    final favorites = await getFavorites();
    return favorites.any((photo) => photo.id == photoId);
  }
  

  // Clear all favorites
  static Future<bool> clearFavorites() async {
    _storage.remove(_favoritesKey);
    return true;
  }
} 