// import '../networking/products_model.dart';

// abstract class ProductDetailState {}

// class ProductDetailInitial extends ProductDetailState {}

// class ProductDetailLoading extends ProductDetailState {}

// class ProductDetailSuccess extends ProductDetailState {
//   final Product? productDetail;

//   ProductDetailSuccess({ required this.productDetail});
// }

// class ProductDetailError extends ProductDetailState {
//   final dynamic error;
//   ProductDetailError(this.error);
// }

import 'package:equatable/equatable.dart';

import '../networking/products_model.dart';


enum Status { loading, init, success, error }

class ProductDetailState extends Equatable {
  final Status status;
  final Product? product;
  final dynamic error;

  const ProductDetailState({
    required this.status,
    this.product,
    required this.error,
  });

  factory ProductDetailState.initial() {
    return const ProductDetailState(status: Status.init, error: null);
  }

  @override
  List<Object?> get props => [status, product, error];

  ProductDetailState copyWith({
    Status? status,
    Product? product,
    dynamic error,
  }) {
    return ProductDetailState(
      status: status ?? this.status,
      product: product ?? this.product,
      error: error ?? this.error,
    );
  }
}
