import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/services/favorites_service.dart';
import '../../../home/domain/entities/photo.dart';

class FavoritesController extends GetxController {
  final RxList<Photo> favorites = <Photo>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    isLoading.value = true;
    try {
      final favoritesList = await FavoritesService.getFavorites();
      favorites.assignAll(favoritesList);
    } catch (e) {
      print('Error loading favorites: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeFromFavorites(int photoId) async {
    try {
      await FavoritesService.removeFromFavorites(photoId);
      favorites.removeWhere((photo) => photo.id == photoId);
      Get.snackbar(
        'Success',
        'Removed from favorites',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF2A2A3E),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to remove from favorites',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFE74C3C),
        colorText: Colors.white,
      );
    }
  }

  Future<void> clearAllFavorites() async {
    try {
      await FavoritesService.clearFavorites();
      favorites.clear();
      Get.snackbar(
        'Success',
        'All favorites cleared',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF2A2A3E),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to clear favorites',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFE74C3C),
        colorText: Colors.white,
      );
    }
  }
} 