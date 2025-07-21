import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/photo.dart';
 
abstract class HomeRepository {
  Future<Either<Failure, List<Photo>>> getPhotos({int page = 1, int limit = 10});
} 