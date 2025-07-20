import 'package:get/get.dart';
import '../../domain/entities/photo_detail.dart';

class DetailsController extends GetxController {
  final Rx<PhotoDetail?> photoDetail = Rx<PhotoDetail?>(null);

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is PhotoDetail) {
      photoDetail.value = args;
    }
  }
} 