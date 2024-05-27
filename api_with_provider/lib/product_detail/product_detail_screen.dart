import 'package:api_with_provider/networking/product_responsitory.dart';
import 'package:api_with_provider/product_detail/product_detail_state.dart';
import 'package:api_with_provider/product_detail/product_detial_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';

import '../networking/products_model.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    return StateNotifierProvider<ProductDetailProvider, ProductDetailState>(
      create: (context) {
        return ProductDetailProvider(
          ProductRepository(),
        );
      },
      child: ProductDetailView(
        productId: productId,
      ),
    );
  }
}

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  Product? args;

  @override
  void initState() {
    super.initState();
    final provider = context.read<ProductDetailProvider>();
    provider.addListener((state) {
      if (state.status == Status.error) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return _buildDialog(context);
          },
        );
      }
    });

    provider.getProductDetail(widget.productId);
  }

  AlertDialog _buildDialog(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Thông báo',
      ),
      content: const Text(
        'Có lỗi xảy ra',
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: <Widget>[
        ElevatedButton(
          child: const Text("Continue"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: const Text(" Cancel "),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildProductDetailSuccessScreen(widget.productId),
      ),
    );
  }

  Center _buildProductDetailSuccessScreen(String id) {
    final ProductDetailState state = context.watch<ProductDetailState>();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (state.status != Status.loading)
            ElevatedButton(
                onPressed: () {
                  context
                      .read<ProductDetailProvider>()
                      .getProductDetail(id, fakeError: true);
                },
                child: const Text('refresh')),
          Stack(alignment: Alignment.center, children: [
            if (state.product != null)
              Text('Product name: ${state.product?.name}'),
            if (state.status == Status.loading)
              const Center(child: CircularProgressIndicator()),
          ]),
        ],
      ),
    );
  }
}
