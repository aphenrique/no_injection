import 'package:flutter/material.dart';

import '../../../../core/colors/app_colors.dart';
import '../fetch_photos_params.dart';
import '../blocs/photos_bloc.dart';
import '../blocs/stores/page_params_store.dart';

class CategoryButton extends StatelessWidget {
  final String term;

  const CategoryButton({
    Key? key,
    required this.term,
    required this.photosBloc,
    required this.pageParams,
  }) : super(key: key);

  final PhotosBloc photosBloc;
  final PageParamsStore pageParams;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: TextButton(
        onPressed: () {
          pageParams.resetApiPage();
          pageParams.resetQuery();

          pageParams.setQuery(term);

          photosBloc.add(
            FetchPhotosEvent(
              query: pageParams.query,
              apiPage: pageParams.apiPage,
              perPage: pageParams.perPage,
            ),
          );
        },
        child: Text(
          term.toUpperCase(),
          style: const TextStyle(color: AppColors.searchFieldColor),
        ),
      ),
    );
  }
}
