import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_urls.dart';
import '../../../../core/services/favorites_service.dart';
import '../controllers/details_controller.dart';
import '../../../home/domain/entities/photo.dart';

class DetailsPage extends GetView<DetailsController> {
  const DetailsPage({super.key});

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
          'Photo Details',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          Obx(() {
            final photo = controller.photoDetail.value;
            if (photo == null) return const SizedBox.shrink();
            return _FavoriteIcon(photoId: photo.id, photo: photo);
          }),
        ],
      ),
      body: Obx(() {
        final photo = controller.photoDetail.value;
        if (photo == null) {
          return const Center(
            child: Text(
              'No photo details found',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Large Image
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFF333333),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    AppUrls.getPlaceholderImageUrl(400, 400, id: photo.id),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFF444444),
                        child: const Icon(
                          Icons.image,
                          color: Colors.white54,
                          size: 80,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Photo Info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A3E),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Title',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      photo.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Photo ID',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${photo.id}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Album ID',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${photo.albumId}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

Photo toPhoto(dynamic photo) {
  if (photo is Photo) return photo;
  // If PhotoDetail, convert
  return Photo(
    albumId: photo.albumId,
    id: photo.id,
    title: photo.title,
    url: photo.url,
    thumbnailUrl: photo.thumbnailUrl,
  );
}

class _FavoriteIcon extends StatefulWidget {
  final int photoId;
  final dynamic photo;
  const _FavoriteIcon({required this.photoId, required this.photo});

  @override
  State<_FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<_FavoriteIcon> {
  bool isFavorite = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final status = await FavoritesService.isFavorite(widget.photoId);
    setState(() {
      isFavorite = status;
    });
  }

  Future<void> _toggleFavorite() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (isFavorite) {
        await FavoritesService.removeFromFavorites(widget.photoId);
        Get.snackbar('Removed', 'Removed from favorites', snackPosition: SnackPosition.BOTTOM, backgroundColor: const Color(0xFF2A2A3E), colorText: Colors.white, duration: const Duration(seconds: 1));
      } else {
        await FavoritesService.addToFavorites(toPhoto(widget.photo));
        Get.snackbar('Added', 'Added to favorites', snackPosition: SnackPosition.BOTTOM, backgroundColor: const Color(0xFF2A2A3E), colorText: Colors.white, duration: const Duration(seconds: 1));
      }
      setState(() {
        isFavorite = !isFavorite;
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to update favorites', snackPosition: SnackPosition.BOTTOM, backgroundColor: const Color(0xFFE74C3C), colorText: Colors.white);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white54,
                strokeWidth: 2,
              ),
            )
          : Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
              size: 24,
            ),
      onPressed: isLoading ? null : _toggleFavorite,
      tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
    );
  }
} 