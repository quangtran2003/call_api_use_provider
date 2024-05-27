import '../networking/products_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<Product> products;
  HomeSuccess({required this.products});
}

class HomeError extends HomeState {
  final dynamic error;
  HomeError({required this.error});
  
}
