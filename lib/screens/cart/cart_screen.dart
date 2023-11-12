import 'package:e_commerce_app/bloc/cubit_app/app_cubit.dart';
import 'package:e_commerce_app/bloc/cubit_app/app_states.dart';
import 'package:e_commerce_app/models/data_model.dart';
import 'package:e_commerce_app/widgets/single_cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key,});
  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
            ),
            title: const Text(
              'Cart',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: 4,
              //cubit.productList.length
              itemBuilder: (context, index) {
                Product singleProductList = cubit.productList[index];
                return SingleCartItem(
                  image: singleProductList.images![0],
                  title: '${singleProductList.title}',
                  price: '${singleProductList.price}',
                  counter: '${cubit.itemCounters[singleProductList.id] ?? 0}',
                  minus: () {
                    cubit.minusItemCounter(singleProductList.id);
                  },
                  plus: () {
                    cubit.plusItemCounter(singleProductList.id);
                  },
                  addToWishList: () {

                  },
                );
              }),
        );
      },
    );
  }
}
