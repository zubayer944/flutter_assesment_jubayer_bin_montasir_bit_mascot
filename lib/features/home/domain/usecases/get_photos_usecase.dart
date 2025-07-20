import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/photo.dart';
import '../repositories/home_repository.dart';

class GetPhotosUseCase implements UseCase<List<Photo>, NoParams> {
  final HomeRepository repository;

  GetPhotosUseCase(this.repository);

  @override
  Future<Either<Failure, List<Photo>>> call(NoParams params) async {
    return await repository.getPhotos();
  }
} 