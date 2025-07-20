import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../data/datasources/home_remote_datasource.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/repositories/home_repository.dart';
import '../../domain/usecases/get_photos_usecase.dart';
import '../../../../core/network/api_client.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Data sources
    Get.lazyPut<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(apiClient: Get.find<ApiClient>()),
    );

    // Repositories
    Get.lazyPut<HomeRepository>(
      () => HomeRepositoryImpl(remoteDataSource: Get.find<HomeRemoteDataSource>()),
    );

    // Use cases
    Get.lazyPut<GetPhotosUseCase>(
      () => GetPhotosUseCase(Get.find<HomeRepository>()),
    );

    // Controllers
    Get.lazyPut<HomeController>(
      () => HomeController(getPhotosUseCase: Get.find<GetPhotosUseCase>()),
    );
  }
} 