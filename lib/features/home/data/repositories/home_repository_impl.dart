import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/photo.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Photo>>> getPhotos({int page = 1, int limit = 10}) async {
    try {
      final photos = await remoteDataSource.getPhotos(page: page, limit: limit);
      return Right(photos);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
} 