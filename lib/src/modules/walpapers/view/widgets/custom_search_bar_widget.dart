import 'package:flutter/material.dart';
import 'package:no_injection/src/modules/walpapers/view/fetch_photos_params.dart';

import '../../../../core/colors/app_colors.dart';
import '../blocs/stores/page_params_store.dart';
import '../list_photos_controler.dart';

class CustomSerchBarWidget extends StatelessWidget implements PreferredSize {
  const CustomSerchBarWidget({
    Key? key,
    required this.controller,
    required this.pageParams,
  }) : super(key: key);

  final ListPhotosControler controller;
  final PageParamsStore pageParams;

  @override
  Widget get child => Container();

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      height: 80,
      child: TextField(
        cursorColor: AppColors.searchFieldColor,
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          pageParams.resetApiPage();

          pageParams.setQuery(value.trim().isNotEmpty ? value : null);

          controller.fetchPhotos(params: 
            PageParamsStore(
              query: pageParams.query,
              apiPage: pageParams.apiPage,
              perPage: pageParams.perPage,
            ),
          );
        },
        style: const TextStyle(
          color: AppColors.searchFieldColor,
        ),
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.searchFieldColor,
          ),
          hintText: 'Search',
          hintStyle: const TextStyle(color: AppColors.searchFieldColor),
          fillColor: AppColors.backgroundColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
