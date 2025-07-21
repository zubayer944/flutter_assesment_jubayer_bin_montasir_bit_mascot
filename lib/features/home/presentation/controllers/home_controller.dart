import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import '../../../../core/utils/base_controller.dart';
import '../../domain/entities/photo.dart';
import '../../domain/usecases/get_photos_usecase.dart';

class HomeController extends BaseController {
  final GetPhotosUseCase getPhotosUseCase;

  HomeController({required this.getPhotosUseCase});

  final RxList<Photo> photos = <Photo>[].obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool hasMore = true.obs;

  int page = 1;
  final int pageSize = 10;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    loadPhotos(reset: true);
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 100 &&
        hasMore.value &&
        !isLoadingMore.value) {
      loadMorePhotos();
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> loadPhotos({bool reset = false}) async {
    if (reset) {
      page = 1;
      hasMore.value = true;
      photos.clear();
      setLoading(true); // from BaseController
    }

    await execute(() async {
      final result =
      await getPhotosUseCase(GetPhotosParams(page: page, limit: pageSize));
      result.fold(
            (failure) {
          handleFailure(failure);
        },
            (newPhotos) {
          if (reset) {
            photos.clear();
            photos.addAll(newPhotos);
          } else {
            photos.addAll(newPhotos);
          }

          hasMore.value = newPhotos.length >= pageSize;
        },
      );

      setLoading(false);
      isLoadingMore.value = false;
    });
  }

  Future<void> loadMorePhotos() async {
    if (isLoadingMore.value || !hasMore.value) return;
    isLoadingMore.value = true;
    page++;
    await loadPhotos();
  }

  Future<void> refreshPhotos() async {
    await loadPhotos(reset: true);
  }
}

