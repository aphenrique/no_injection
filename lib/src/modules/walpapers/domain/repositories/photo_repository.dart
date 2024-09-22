import '../../../../core/utils/either.dart';
import '../../data/repositories/photo_repository_impl.dart';
import '../entities/photo_entity.dart';
import '../erros/photo_exception.dart';

abstract class PhotoRepository {
  factory PhotoRepository() => PhotoRepositoryImpl();

  Future<Either<PhotoException, List<PhotoEntity>>> fetchPhotos(
      {String? query, required int apiPage, required int perPage});
}
