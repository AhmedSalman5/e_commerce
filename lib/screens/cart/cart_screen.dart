import 'package:e_commerce_app/bloc/cubit_app/app_cubit.dart';
import 'package:e_commerce_app/bloc/cubit_app/app_states.dart';
import 'package:e_commerce_app/widgets/single_cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/data_model.dart';
import '../../widgets/tost_message.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    super.key,
  });
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
          body: cubit.cartList.isEmpty ? const Center(
            child: Text('Cart is Empty',style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                  fontWeight: FontWeight.w700,
                ),),
          ) : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: cubit.cartList.length,
              itemBuilder: (context, index) {
                String key = cubit.cartList.keys.elementAt(index);
                var singleItem = cubit.cartList[key]!;
                  return SingleCartItem(
                  image: singleItem is Product ? singleItem.images![0] : singleItem.image,
                  title: '${singleItem.title}',
                  price: '${singleItem.price}',
                  counter: '${cubit.itemCounters[singleItem.id] ?? 0}',
                  minus: () {
                    cubit.minusItemCounter(singleItem.id);
                  },
                  plus: () {
                    cubit.plusItemCounter(singleItem.id);
                  },
                  addToWishList: () {

                  },
                  delete: () {
                    cubit.removeCartList('${singleItem.id}');
                    showMessage('Removed from cart');
                  },
                );
              }),
        );
      },
    );
  }
}



