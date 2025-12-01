import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/constants/app_strings.dart';
import 'package:flutter_task/core/utilities/extensions/context_extension.dart';
import 'package:flutter_task/features/search/presentation/bloc/search_bloc.dart';
import 'package:flutter_task/features/search/presentation/bloc/search_event.dart';
import 'package:flutter_task/features/search/presentation/bloc/search_state.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController searchController;

  const SearchAppBar({
    super.key,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextField(
        controller: searchController,
        autofocus: true,
        decoration: InputDecoration(
          hintText: AppStrings.searchProducts,
          border: InputBorder.none,
          hintStyle: context.appTextStyles.font14Regular.copyWith(
            color: context.appColors.thirdColor,
          ),
        ),
        style: context.appTextStyles.font14Regular,
        onChanged: (query) {
          context.read<SearchBloc>().add(SearchQueryChanged(query));
        },
      ),
      actions: [
        BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state.query.isNotEmpty) {
              return IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  searchController.clear();
                  context.read<SearchBloc>().add(SearchCleared());
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

