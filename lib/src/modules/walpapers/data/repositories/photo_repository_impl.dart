import '../../../../core/utils/either.dart';
import '../../domain/entities/photo_entity.dart';
import '../../domain/erros/photo_exception.dart';
import '../../domain/repositories/photo_repository.dart';
import '../datasouces/photo_datasource.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoDatasource _photoDatasource;

  PhotoRepositoryImpl({PhotoDatasource? photoDatasource})
      : _photoDatasource = photoDatasource ?? PhotoDatasource();

  @override
  Future<Either<PhotoException, List<PhotoEntity>>> fetchPhotos(
      {String? query, required int apiPage, required int perPage}) async {
    try {
      if (query != null) {
        final result = await _photoDatasource.searchPhotos(
            query: query, apiPage: apiPage, perPage: perPage);
        return right(result);
      } else {
        final result = await _photoDatasource.fetchPhotos(
            apiPage: apiPage, perPage: perPage);
        return right(result);
      }
    } on PhotoDatasourceException catch (e) {
      return left(PhotoDatasourceException(e.toString()));
    }
  }
}

