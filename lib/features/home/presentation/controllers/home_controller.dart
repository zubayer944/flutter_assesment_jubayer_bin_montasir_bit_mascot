import 'package:get/get.dart';
import '../../../../core/utils/usecase.dart';
import '../../domain/entities/photo.dart';
import '../../domain/usecases/get_photos_usecase.dart';
import '../../../../core/utils/base_controller.dart';
import '../../../../core/errors/failures.dart';

class HomeController extends BaseController {
  final GetPhotosUseCase getPhotosUseCase;

  HomeController({required this.getPhotosUseCase});

  final RxList<Photo> photos = <Photo>[].obs;
  int page = 1;
  final int pageSize = 10;
  bool isLoadingMore = false;
  bool hasMore = true;

  @override
  void onInit() {
    super.onInit();
    loadPhotos(reset: true);
  }

  Future<void> loadPhotos({bool reset = false}) async {
    if (reset) {
      page = 1;
      hasMore = true;
      photos.clear();
    }
    await execute(() async {
      final result = await getPhotosUseCase(NoParams());
      result.fold(
        (failure) {
          handleFailure(failure);
        },
        (photosList) {
          // Simulate pagination by slicing
          final start = (page - 1) * pageSize;
          final end = (start + pageSize) > photosList.length ? photosList.length : (start + pageSize);
          final newItems = photosList.sublist(start, end);
          if (reset) {
            photos.value = newItems;
          } else {
            photos.addAll(newItems);
          }
          hasMore = end < photosList.length;
          isLoadingMore = false;
        },
      );
    });
  }

  Future<void> loadMorePhotos() async {
    if (isLoadingMore || !hasMore) return;
    isLoadingMore = true;
    page++;
    await loadPhotos();
    isLoadingMore = false;
  }

  Future<void> refreshPhotos() async {
    await loadPhotos(reset: true);
  }
} 