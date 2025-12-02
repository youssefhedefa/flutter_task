import 'package:flutter/material.dart';
import 'package:flutter_task/core/constants/app_strings.dart';
import 'package:flutter_task/core/utilities/extensions/context_extension.dart';
import 'package:flutter_task/core/utilities/extensions/num_extension.dart';

class SearchErrorWidget extends StatelessWidget {
  final String? errorMessage;

  const SearchErrorWidget({
    super.key,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: context.appColors.primaryColor.withAlpha(153),
          ),
          16.verticalSpace,
          Text(
            errorMessage ?? AppStrings.somethingWentWrong,
            style: context.appTextStyles.font14Regular,
          ),
        ],
      ),
    );
  }
}

