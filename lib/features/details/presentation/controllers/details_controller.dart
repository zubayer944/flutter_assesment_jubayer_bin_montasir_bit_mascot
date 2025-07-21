import 'package:get/get.dart';
import '../../domain/entities/photo_detail.dart';
import '../../../home/domain/entities/photo.dart';

class DetailsController extends GetxController {
  final Rx<PhotoDetail?> photoDetail = Rx<PhotoDetail?>(null);

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null) {
      if (args is PhotoDetail) {
        photoDetail.value = args;
      } else if (args is Photo) {
        photoDetail.value = PhotoDetail(
          albumId: args.albumId,
          id: args.id,
          title: args.title,
          url: args.url,
          thumbnailUrl: args.thumbnailUrl,
        );
      }
    }
  }
} 