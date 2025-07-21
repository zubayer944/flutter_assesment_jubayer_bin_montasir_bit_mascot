import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_urls.dart';
import '../../../../core/config/app_routes.dart';
import '../controllers/favorites_controller.dart';

class FavoritesPage extends GetView<FavoritesController> {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Favorites',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          Obx(() {
            if (controller.favorites.isNotEmpty) {
              return IconButton(
                icon: const Icon(Icons.delete_sweep, color: Colors.white),
                onPressed: () => _showClearDialog(),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }

        if (controller.favorites.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border,
                  size: 80,
                  color: Colors.white.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  'No favorites yet',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Add photos to your favorites to see them here',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.favorites.length,
          separatorBuilder: (context, index) => const Divider(
            color: Color(0xFF333333),
            height: 1,
            thickness: 1,
          ),
          itemBuilder: (context, index) {
            final photo = controller.favorites[index];
            return _buildFavoriteItem(photo);
          },
        );
      }),
    );
  }

  Widget _buildFavoriteItem(photo) {
    String imageUrl = AppUrls.getPlaceholderImageUrl(150, 150, id: photo.id);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          // Photo Thumbnail
          GestureDetector(
            onTap: () => AppRoutes.navigateToDetails(photo),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFF333333),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFF444444),
                      child: const Icon(
                        Icons.image,
                        color: Colors.white54,
                        size: 30,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Photo Info
          Expanded(
            child: GestureDetector(
              onTap: () => AppRoutes.navigateToDetails(photo),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    photo.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Album ID: ${photo.albumId}',
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Remove from favorites button
          IconButton(
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
              size: 24,
            ),
            onPressed: () => controller.removeFromFavorites(photo.id),
          ),
        ],
      ),
    );
  }

  void _showClearDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF2A2A3E),
        title: const Text(
          'Clear All Favorites',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to remove all favorites? This action cannot be undone.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.clearAllFavorites();
            },
            child: const Text(
              'Clear All',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
} 