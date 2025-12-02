import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/utilities/enums/request_status_enum.dart';
import 'package:flutter_task/features/search/presentation/bloc/search_bloc.dart';
import 'package:flutter_task/features/search/presentation/bloc/search_state.dart';
import 'package:flutter_task/features/search/presentation/widgets/search_app_bar.dart';
import 'package:flutter_task/features/search/presentation/widgets/search_empty_widget.dart';
import 'package:flutter_task/features/search/presentation/widgets/search_error_widget.dart';
import 'package:flutter_task/features/search/presentation/widgets/search_initial_widget.dart';
import 'package:flutter_task/features/search/presentation/widgets/search_loading_widget.dart';
import 'package:flutter_task/features/search/presentation/widgets/search_results_widget.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(searchController: _searchController),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return switch (state.status) {
            RequestStatusEnum.initial => SearchInitialWidget(),
            RequestStatusEnum.loading => const SearchLoadingWidget(),
            RequestStatusEnum.success => state.products.isEmpty
                ? SearchEmptyWidget()
                : SearchResultsWidget(products: state.products),
            RequestStatusEnum.failure => SearchErrorWidget(
                errorMessage: state.errorMessage,
              ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}
