import 'package:e_commerce_app/bloc/cubit_app/app_cubit.dart';
import 'package:e_commerce_app/bloc/cubit_app/app_states.dart';
import 'package:e_commerce_app/constants/routes.dart';
import 'package:e_commerce_app/models/data_model.dart';
import 'package:e_commerce_app/screens/cart/cart_screen.dart';
import 'package:e_commerce_app/widgets/tost_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetails extends StatelessWidget {
  final Product singleProduct;
  const ProductDetails({super.key, required this.singleProduct});

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          //var id = singleProduct.id;
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
              actions: [
                IconButton(
                    onPressed: () {
                      Routes.instance
                          .push(context: context, widget: const CartScreen());
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                    )),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      singleProduct.images![0],
                      height: 350,
                      width: 350
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingBar.builder(
                          initialRating:
                              cubit.ratingCounter[singleProduct.id] ?? 0,
                          allowHalfRating: true,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (double value) {
                            cubit.ratingItemCounter(singleProduct.id, value);
                          },
                          // updateOnDrag: false,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          cubit.ratingCounter[singleProduct.id] == null ||
                                  cubit.ratingCounter[singleProduct.id] == 0
                              ? ''
                              : '${cubit.ratingCounter[singleProduct.id]}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${singleProduct.title}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            bool isCurrentlyFavorite = cubit.isFavorite[singleProduct.id] ?? false;
                            if (isCurrentlyFavorite) {
                              cubit.removeFavorite('${singleProduct.id}');
                              cubit.changeFavoriteProduct(singleProduct.id!);
                              showMessage('Removed from Favorite');
                              // print('تم الحذف من المفضله');
                            } else {
                              cubit.addCFavorite(itemId: '${singleProduct.id}', value: singleProduct);
                              cubit.changeFavoriteProduct(singleProduct.id!);
                              showMessage('Added to Favorite');
                              // print('تم الاضافه الي المفضله');
                            }
                          },
                          icon: cubit.isFavorite[singleProduct.id] ?? false
                              ? const Icon(Icons.favorite, color: Colors.red)
                              : const Icon(Icons.favorite_border),
                        ),
                      ],
                    ),
                    Text(
                      "${singleProduct.description}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          child: IconButton(
                              onPressed: () {
                                cubit.minusItemCounter(singleProduct.id!);
                              },
                              icon: const Icon(Icons.remove)),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          '${cubit.itemCounters[singleProduct.id] ?? 0}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        CircleAvatar(
                          child: IconButton(
                              onPressed: () {
                                cubit.plusItemCounter(singleProduct.id!);
                              },
                              icon: const Icon(Icons.add)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 38,
                          width: 140,
                          child: OutlinedButton(
                            onPressed: () {
                              cubit.addCartList(itemId: '${singleProduct.id}', value: singleProduct);
                              showMessage('Added to cart');
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.green,
                              side: const BorderSide(
                                color: Colors.green,
                                width: 1.7,
                              ),
                            ),
                            child: const Text('ADD TO CART'),
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        SizedBox(
                          height: 38,
                          width: 140,
                          child: ElevatedButton(
                              onPressed: () {
                                // Routes.instance.push(
                                //     context: context,
                                //     widget: const FavoriteScreen(),
                                // );
                              }, child: const Text('BUY')),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
