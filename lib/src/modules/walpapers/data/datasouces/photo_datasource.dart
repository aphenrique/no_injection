import '../../../../core/external/api_photo_datasource.dart';
import '../../domain/entities/photo_entity.dart';

abstract class PhotoDatasource {
  factory PhotoDatasource() => ApiPhotoDatasource();

  Future<List<PhotoEntity>> fetchPhotos(
      {required int apiPage, required int perPage});
  Future<List<PhotoEntity>> searchPhotos(
      {required String query, required int apiPage, required int perPage});
}
