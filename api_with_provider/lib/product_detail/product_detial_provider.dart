// ignore_for_file: use_build_context_synchronously

import 'package:flutter_state_notifier/flutter_state_notifier.dart';

import '../networking/product_responsitory.dart';
import 'product_detail_state.dart';

class ProductDetailProvider extends StateNotifier<ProductDetailState> {
  final ProductRepository repo;
  ProductDetailProvider(this.repo) : super(ProductDetailState.initial());

  Future getProductDetail(String id, {bool fakeError = false}) async {
    state = state.copyWith(status: Status.loading);

    try {
      final data = await repo.getProductDetail(id);

      state = state.copyWith(product: data, status: Status.success);

      if (fakeError == true) {
        throw Exception("Có lỗi xảy ra");
      }
    } catch (e) {
      state = state.copyWith(status: Status.error);
    }
  }
}
