import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/config/app_routes.dart';
import '../../../../core/constants/app_urls.dart';
import '../controllers/home_controller.dart';
import '../../domain/entities/photo.dart';
import 'favorite_button.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100 && 
          controller.hasMore && !controller.isLoadingMore) {
        controller.loadMorePhotos();
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E), // Dark purple background
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        title: const Text(
          'Photos',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.white),
            onPressed: () => AppRoutes.navigateToFavorites(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }

        if (controller.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error: ${controller.errorMessage}',
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.refreshPhotos,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (controller.photos.isEmpty) {
          return const Center(
            child: Text(
              'No photos found',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshPhotos,
          child: ListView.builder(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: controller.photos.length + (controller.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < controller.photos.length) {
                final photo = controller.photos[index];
                return Column(
                  children: [
                    _buildPhotoItem(photo),
                    if (index < controller.photos.length - 1)
                      const Divider(
                        color: Color(0xFF333333),
                        height: 1,
                        thickness: 1,
                      ),
                  ],
                );
              } else {
                // Show loading indicator at the bottom
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: CupertinoActivityIndicator(radius: 14),
                  ),
                );
              }
            },
          ),
        );
      }),
    );
  }

  Widget _buildPhotoItem(Photo photo) {
    // Use AppUrls method for placeholder image
    String imageUrl = AppUrls.getPlaceholderImageUrl(150, 150, id: photo.id);
    
    return GestureDetector(
      onTap: () => AppRoutes.navigateToDetails(photo),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            // Photo Thumbnail
            Container(
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
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: const Color(0xFF444444),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white54,
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Photo Info
            Expanded(
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
            // Favorite button
            FavoriteButton(photo: photo),
          ],
        ),
      ),
    );
  }
} 