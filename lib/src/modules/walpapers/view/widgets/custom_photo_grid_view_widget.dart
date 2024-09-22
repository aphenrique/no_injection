import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/photo_entity.dart';
import '../fetch_photos_params.dart';
import '../blocs/photos_bloc.dart';
import '../blocs/states/photos_state.dart';
import '../blocs/stores/page_params_store.dart';
import 'custom_small_photo_widget.dart';

class CustomPhotoGridViewWidget extends StatefulWidget {
  const CustomPhotoGridViewWidget({
    Key? key,
    required this.photosBloc,
    required this.pageParams,
  }) : super(key: key);

  final PhotosBloc photosBloc;
  final PageParamsStore pageParams;

  @override
  State<CustomPhotoGridViewWidget> createState() =>
      _CustomPhotoGridViewWidgetState();
}

class _CustomPhotoGridViewWidgetState extends State<CustomPhotoGridViewWidget> {
  List<PhotoEntity> photos = [];

  PhotosBloc get photosBloc => widget.photosBloc;
  PageParamsStore get pageParams => widget.pageParams;

  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController();
    scrollController.addListener(
      () {
        if (scrollController.offset >=
                scrollController.position.maxScrollExtent - 80 &&
            photosBloc.state is FetchPhotosSucess) {
          pageParams.incrementApiPage();

          photosBloc.add(
            FetchPhotosEvent(
              query: pageParams.query,
              apiPage: pageParams.apiPage,
              perPage: pageParams.perPage,
            ),
          );
        }
      },
    );

    photosBloc.add(
      FetchPhotosEvent(
        apiPage: pageParams.apiPage,
        perPage: pageParams.perPage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotosBloc, PhotosState>(
      bloc: photosBloc,
      builder: (context, state) {
        if (state is FetchPhotosInitial) {
          photos.clear();
          pageParams.resetApiPage();
          return Container();
        }

        if (state is FetchPhotosLoading && photos.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is FetchPhotosError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                state.message,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  photosBloc.add(
                    FetchPhotosEvent(
                      query: pageParams.query,
                      apiPage: pageParams.apiPage,
                      perPage: pageParams.perPage,
                    ),
                  );
                },
                child: const Text('Tentar novamente'),
              ),
            ],
          );
        }

        if (state is FetchPhotosSucess) photos.addAll(state.photos);

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    childAspectRatio: MediaQuery.of(context).size.aspectRatio,
                    maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  controller: scrollController,
                  itemCount: photos.length,
                  itemBuilder: (context, index) {
                    final photo = photos[index];

                    return CustomSmallPhotoWidget(photoPath: photo.photoPath);
                  },
                ),
              ),
              if (state is FetchPhotosLoading)
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        );
      },
    );
  }
}
