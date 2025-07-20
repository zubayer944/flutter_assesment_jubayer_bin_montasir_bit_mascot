import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/photo.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Photo>>> getPhotos();
} 