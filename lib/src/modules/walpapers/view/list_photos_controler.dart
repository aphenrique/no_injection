import 'package:flutter/material.dart';
import 'package:no_injection/src/modules/walpapers/domain/usecases/fetch_photos_usecase.dart';
import 'package:no_injection/src/modules/walpapers/view/blocs/states/photos_state.dart';
import 'package:no_injection/src/modules/walpapers/view/fetch_photos_params.dart';

import 'blocs/stores/page_params_store.dart';

class ListPhotosControler extends ValueNotifier<PhotosState> {
  ListPhotosControler({FetchPhotosUsecase? fetchPhotosUsecase})
      : _fetchPhotosUsecase = fetchPhotosUsecase ?? FetchPhotosUsecase(),
        super(FetchPhotosInitial());

  final FetchPhotosUsecase _fetchPhotosUsecase;

 
  fetchPhotos({required PageParamsStore params}) async {
    if (params.apiPage == 1) {
      value = FetchPhotosInitial();
      await Future.delayed(const Duration(milliseconds: 200));
    }

    value = FetchPhotosLoading();

    final response = await _fetchPhotosUsecase(
      query: params.query,
      apiPage: params.apiPage,
      perPage: params.perPage,
    );

    value = response.fold(
      (failure) => FetchPhotosError('Erro ao buscar fotos'),
      (photos) {
        return FetchPhotosSucess(photos);
      },
    );
  }
}
