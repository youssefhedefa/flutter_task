import 'package:equatable/equatable.dart';
import 'package:flutter_task/core/utilities/enums/request_status_enum.dart';
import 'package:flutter_task/features/home/domain/entities/product_entity.dart';

class SearchState extends Equatable {
  final RequestStatusEnum status;
  final List<ProductEntity> products;
  final String query;
  final String? errorMessage;

  const SearchState({
    this.status = RequestStatusEnum.initial,
    this.products = const [],
    this.query = '',
    this.errorMessage,
  });

  SearchState copyWith({
    RequestStatusEnum? status,
    List<ProductEntity>? products,
    String? query,
    String? errorMessage,
  }) {
    return SearchState(
      status: status ?? this.status,
      products: products ?? this.products,
      query: query ?? this.query,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        products,
        query,
        errorMessage,
      ];
}

