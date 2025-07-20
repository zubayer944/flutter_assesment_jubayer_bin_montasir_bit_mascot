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

  @override
  void onInit() {
    super.onInit();
    loadPhotos();
  }

  Future<void> loadPhotos() async {
    await execute(() async {
      final result = await getPhotosUseCase(NoParams());

      result.fold(
        (failure) {
          handleFailure(failure);
        },
        (photosList) {
          photos.value = photosList;
        },
      );
    });
  }

  Future<void> refreshPhotos()async {
    await loadPhotos();
  }
} 