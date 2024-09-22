import 'package:flutter/material.dart';
import 'package:no_injection/src/modules/walpapers/view/blocs/stores/page_params_store.dart';

import '../../../core/colors/app_colors.dart';
import 'components/per_page_slide_component.dart';
import 'list_photos_controler.dart';
import 'widgets/categories_list_widget.dart';
import 'widgets/custom_photo_grid_view_widget.dart';
import 'widgets/custom_search_bar_widget.dart';

class ListPhotosPage extends StatefulWidget {
  const ListPhotosPage({
    Key? key,
    required this.controller,
    required this.pageParams,
  }) : super(key: key);

  final ListPhotosControler controller;
  final PageParamsStore pageParams;

  @override
  State<ListPhotosPage> createState() => _ListPhotosPageState();
}

class _ListPhotosPageState extends State<ListPhotosPage> {
  ListPhotosControler get controller => widget.controller;
  PageParamsStore get pageParams => widget.pageParams;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Wallpaper',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 28,
            letterSpacing: 2.0,
          ),
        ),
        actions: [
          PerPageSlideComponent(pageParams: pageParams),
        ],
        bottom: CustomSerchBarWidget(
          controller: controller,
          pageParams: pageParams,
        ),
      ),
      body: Column(
        children: [
          CategoriesListWidget(
            controller: controller,
            pageParams: pageParams,
          ),
          Expanded(
            child: CustomPhotoGridViewWidget(
              controller: controller,
              pageParams: pageParams,
            ),
          ),
        ],
      ),
    );
  }
}
