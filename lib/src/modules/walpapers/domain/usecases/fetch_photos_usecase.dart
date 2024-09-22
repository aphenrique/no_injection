import '../../../../core/utils/either.dart';
import '../entities/photo_entity.dart';
import '../erros/photo_exception.dart';
import '../repositories/photo_repository.dart';

abstract class FetchPhotosUsecase {
  factory FetchPhotosUsecase() => FetchPhotosUsecaseImpl();

  Future<Either<PhotoException, List<PhotoEntity>>> call(
      {String? query, required int apiPage, required int perPage});
}

class FetchPhotosUsecaseImpl implements FetchPhotosUsecase {
  FetchPhotosUsecaseImpl({PhotoRepository? repository})
      : _repository = repository ?? PhotoRepository();

  final PhotoRepository _repository;

  @override
  Future<Either<PhotoException, List<PhotoEntity>>> call(
      {String? query, required int apiPage, required int perPage}) async {
    if (apiPage < 1 || perPage < 1) {
      return left(PhotoParamsException('Parâmetros fora da faixa'));
    }

    if (query != null && query.trim().isEmpty) {
      return left(PhotoParamsException('Favor preencher a pesquisa'));
    }

    return await _repository.fetchPhotos(
        query: query, apiPage: apiPage, perPage: perPage);
  }
}
