import 'package:api_with_provider/home/home_state.dart';
import 'package:api_with_provider/networking/product_responsitory.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';

import '../const.dart';

class HomeProvider extends StateNotifier<HomeState> {
  final ProductRepository repo;
  HomeProvider(this.repo) : super(HomeInitial());

  Future<void> fetchData() async {
    state = HomeLoading();
    try {
      final data = await repo.getProduct(myDio);
      state = HomeSuccess(products: data);
    } catch (e) {
      state = HomeError(error: e);
    }
  }
}
