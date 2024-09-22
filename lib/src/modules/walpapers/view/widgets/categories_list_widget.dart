import 'package:flutter/material.dart';

import '../blocs/photos_bloc.dart';
import '../blocs/stores/page_params_store.dart';
import 'category_button_widget.dart';

class CategoriesListWidget extends StatelessWidget {
  CategoriesListWidget({
    Key? key,
    required this.photosBloc,
    required this.pageParams,
  }) : super(key: key);

  final PhotosBloc photosBloc;
  final PageParamsStore pageParams;

  final categories = <String>['face', 'animal', 'nature', 'car'];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: categories
          .map(
            (e) => CategoryButton(
              term: e,
              photosBloc: photosBloc,
              pageParams: pageParams,
            ),
          )
          .toList(),
    );
  }
}
