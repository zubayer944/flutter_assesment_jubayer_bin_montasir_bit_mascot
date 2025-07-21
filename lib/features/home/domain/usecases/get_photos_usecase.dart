import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/photo.dart';
import '../repositories/home_repository.dart';

class GetPhotosParams {
  final int page;
  final int limit;
  GetPhotosParams({required this.page, required this.limit});
}

class GetPhotosUseCase implements UseCase<List<Photo>, GetPhotosParams> {
  final HomeRepository repository;

  GetPhotosUseCase(this.repository);

  @override
  Future<Either<Failure, List<Photo>>> call(GetPhotosParams params) async {
    return await repository.getPhotos(page: params.page, limit: params.limit);
  }
} 