import '../../modules/walpapers/data/datasouces/photo_datasource.dart';
import '../../modules/walpapers/data/dto/photo_entity_dto.dart';
import '../../modules/walpapers/domain/erros/photo_exception.dart';
import 'http_service.dart';

class ApiPhotoDatasource implements PhotoDatasource {
  final HttpService _service;

  ApiPhotoDatasource({HttpService? service})
      : _service = service ?? HttpService();

  @override
  Future<List<PhotoEntityDto>> fetchPhotos(
      {required int apiPage, required int perPage}) async {
    try {
      final result =
          await _service.get("curated?page=$apiPage&per_page=$perPage");

      var list = result['photos'] as List;

      final photos = list.map((e) => PhotoEntityDto.fromMap(e)).toList();

      return photos;
    } on LostInternetConnection catch (_) {
      throw PhotoDatasourceException(
          'Falha na conexão, \ntente novamente mais tarde!');
    } catch (e) {
      throw PhotoDatasourceException(e.toString());
    }
  }

  @override
  Future<List<PhotoEntityDto>> searchPhotos(
      {required String query,
      required int apiPage,
      required int perPage}) async {
    try {
      final result = await _service
          .get("search?query=$query&page=$apiPage&per_page=$perPage");

      var list = result['photos'] as List;

      final photos = list.map((e) => PhotoEntityDto.fromMap(e)).toList();

      return photos;
    } on LostInternetConnection catch (_) {
      throw PhotoDatasourceException('Falha na conexão!');
    } catch (e) {
      throw PhotoDatasourceException(e.toString());
    }
  }
}
