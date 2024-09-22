import 'package:flutter/material.dart';
import 'package:no_injection/src/core/utils/extensions/args_extension.dart';
import 'package:no_injection/src/modules/walpapers/view/blocs/stores/page_params_store.dart';

import 'core/colors/app_colors.dart';
import 'modules/walpapers/view/list_photos_controler.dart';
import 'modules/walpapers/view/list_photos_page.dart';
import 'modules/walpapers/view/photo_detail_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WallPapers',
      theme: ThemeData(
        primarySwatch: AppColors.customColor,
        snackBarTheme: SnackBarThemeData(
            backgroundColor: AppColors.customColor,
            contentTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            behavior: SnackBarBehavior.floating,
            elevation: 8),
      ),
      routes: <String, Widget Function(BuildContext)>{
        '/': (context) => ListPhotosPage(
              controller: ListPhotosControler(),
              pageParams: PageParamsStore(),
            ),
        '/photoDetail': (context) => PhotoDetailPage(
              imagePath: context.args<String>(),
            ),
      },
    );
  }
}
