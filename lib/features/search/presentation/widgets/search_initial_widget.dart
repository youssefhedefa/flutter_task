import 'package:flutter/material.dart';
import 'package:flutter_task/core/constants/app_strings.dart';
import 'package:flutter_task/core/utilities/extensions/context_extension.dart';
import 'package:flutter_task/core/utilities/extensions/num_extension.dart';

class SearchInitialWidget extends StatelessWidget {
  const SearchInitialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 80,
            color: context.appColors.thirdColor.withAlpha(128),
          ),
          16.verticalSpace,
          Text(
            AppStrings.searchForProducts,
            style: context.appTextStyles.font14Regular.copyWith(
              color: context.appColors.thirdColor,
            ),
          ),
        ],
      ),
    );
  }
}
