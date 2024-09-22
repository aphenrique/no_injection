import 'package:flutter/material.dart';

import '../../../../core/colors/app_colors.dart';
import '../blocs/stores/page_params_store.dart';

class PerPageSlideComponent extends StatefulWidget {
  const PerPageSlideComponent({
    Key? key,
    required this.pageParams,
  }) : super(key: key);

  final PageParamsStore pageParams;

  @override
  State<PerPageSlideComponent> createState() => _PerPageSlideComponentState();
}

class _PerPageSlideComponentState extends State<PerPageSlideComponent> {
  PageParamsStore get pageParams => widget.pageParams;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      icon: const Icon(Icons.grid_view_rounded),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: ValueListenableBuilder<int>(
              valueListenable: pageParams.perpage,
              builder: (context, value, child) => Column(
                children: [
                  Text(
                    '$value fotos por página',
                    style: const TextStyle(
                      color: AppColors.customColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Slider(
                    min: 4,
                    max: 20,
                    divisions: 8,
                    value: value.toDouble(),
                    onChanged: (double value) {
                      pageParams.setPerPage(
                        value.toInt(),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ];
      },
    );
  }
}
