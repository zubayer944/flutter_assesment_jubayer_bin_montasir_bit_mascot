import 'package:get/get.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/storage/storage_service.dart';
import '../controllers/auth_controller.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<StorageService>()) {
      Get.lazyPut<StorageService>(() => StorageServiceImpl());
    }
    if (!Get.isRegistered<ApiClient>()) {
      Get.lazyPut<ApiClient>(() => ApiClient.instance);
    }
    // Data source
    Get.lazyPut<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(Get.find<ApiClient>()),
    );
    // Repository
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: Get.find<AuthRemoteDataSource>(),
        apiClient: Get.find<ApiClient>(),
      ),
    );
    // Use case
    Get.lazyPut<LoginUseCase>(
      () => LoginUseCase(Get.find<AuthRepository>()),
    );
    // Controller
    Get.lazyPut<AuthController>(
      () => AuthController(loginUseCase: Get.find<LoginUseCase>()),
    );
  }
} 