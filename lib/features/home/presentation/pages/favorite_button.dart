import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../core/services/favorites_service.dart';
import '../../domain/entities/photo.dart';

class FavoriteButton extends StatefulWidget {
  final Photo photo;

  const FavoriteButton({
    super.key,
    required this.photo,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;
  bool isLoading = false;
  late final VoidCallback _favoritesListener;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
    // Listen to changes in the favorites key
    _favoritesListener = () {
      _checkFavoriteStatus();
    };
    GetStorage().listenKey('favorites', (_) => _favoritesListener());
  }

  @override
  void dispose() {
    // No need to remove listener for GetStorage.listenKey
    super.dispose();
  }

  Future<void> _checkFavoriteStatus() async {
    final status = await FavoritesService.isFavorite(widget.photo.id);
    if (mounted) {
      setState(() {
        isFavorite = status;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (isFavorite) {
        await FavoritesService.removeFromFavorites(widget.photo.id);
        Get.snackbar(
          'Removed',
          'Removed from favorites',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF2A2A3E),
          colorText: Colors.white,
          duration: const Duration(seconds: 1),
        );
      } else {
        await FavoritesService.addToFavorites(widget.photo);
        Get.snackbar(
          'Added',
          'Added to favorites',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF2A2A3E),
          colorText: Colors.white,
          duration: const Duration(seconds: 1),
        );
      }
      // _checkFavoriteStatus will be called by the listener
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update favorites',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFE74C3C),
        colorText: Colors.white,
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
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
              color: isFavorite ? Colors.red : Colors.white54,
              size: 24,
            ),
      onPressed: isLoading ? null : _toggleFavorite,
    );
  }
} 