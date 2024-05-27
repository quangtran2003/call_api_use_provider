import 'package:api_with_provider/home/home_provider.dart';
import 'package:api_with_provider/home/home_state.dart';
import 'package:api_with_provider/networking/product_responsitory.dart';
import 'package:api_with_provider/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<HomeProvider, HomeState>(
        create: (context) => HomeProvider(
              ProductRepository(),
            ),
        child: const HomeView());
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeProvider>().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) {
          if (state is HomeInitial) return const Text('Chờ 1 chút');
          if (state is HomeLoading) return const CircularProgressIndicator();
          if (state is HomeError) return const Text('Có lỗi xảy ra');
          if (state is HomeSuccess) {
            return _buildHomeSuccessScreen(state);
          }
          return Container();
        },
      ),
    );
  }

  Column _buildHomeSuccessScreen(HomeSuccess state) {
    return Column(
      children: [
        Column(
          children: [
            Center(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              PRODUCT_DETAIL_SCREEN,
                              arguments: state.products[index].id,
                            );
                          },
                          child: Text(state.products[index].name.toString()));
                    })),
          ],
        )
      ],
    );
  }
}
