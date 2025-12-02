import 'package:flutter/material.dart';
import 'package:flutter_task/core/utilities/extensions/context_extension.dart';
import 'package:flutter_task/core/widgets/custom_svg_builder.dart';

class CustomBottomNavItem extends BottomNavigationBarItem {
  CustomBottomNavItem({
    required String iconPath,
    required String label,
    required bool isSelected,
    required BuildContext context,
    double iconSize = 24,
  }) : super(
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: CustomSvgBuilder(
              path: iconPath,
              color: isSelected ? context.appColors.primaryColor : context.appColors.thirdColor,
              width: iconSize,
              height: iconSize,
            ),
          ),
          label: label,
        );
}

