import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/utilities/enums/request_status_enum.dart';
import 'package:flutter_task/features/search/domain/usecases/search_products_usecase.dart';
import 'package:flutter_task/features/search/presentation/bloc/search_event.dart';
import 'package:flutter_task/features/search/presentation/bloc/search_state.dart';
import 'package:stream_transform/stream_transform.dart';

EventTransformer<T> debounceTransformer<T>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchProductsUseCase _searchProductsUseCase;
  static const _debounceDuration = Duration(milliseconds: 500);

  SearchBloc({
    required SearchProductsUseCase searchProductsUseCase,
  })  : _searchProductsUseCase = searchProductsUseCase,
        super(const SearchState()) {
    on<SearchQueryChanged>(
      _onSearchQueryChanged,
      transformer: debounceTransformer(_debounceDuration),
    );
    on<SearchCleared>(_onSearchCleared);
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      emit(state.copyWith(
        status: RequestStatusEnum.initial,
        products: [],
        query: query,
      ));
      return;
    }

    emit(state.copyWith(
      status: RequestStatusEnum.loading,
      query: query,
    ));

    final result = await _searchProductsUseCase.execute(query);

    result.when(
      success: (products) {
        emit(state.copyWith(
          status: RequestStatusEnum.success,
          products: products,
          errorMessage: null,
        ));
      },
      failure: (error) {
        emit(state.copyWith(
          status: RequestStatusEnum.failure,
          errorMessage: error.message,
          products: [],
        ));
      },
    );
  }

  void _onSearchCleared(
    SearchCleared event,
    Emitter<SearchState> emit,
  ) {
    emit(const SearchState());
  }
}

