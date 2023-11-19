import 'package:e_commerce_app/bloc/cubit_app/app_cubit.dart';
import 'package:e_commerce_app/bloc/cubit_app/app_states.dart';
import 'package:e_commerce_app/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../constants/routes.dart';
import '../../widgets/tost_message.dart';
import '../cart/cart_screen.dart';
import '../favorite/favorite_screen.dart';

class CategoryView extends StatelessWidget {
  final CategoryModel singleCategoryModel;
  const CategoryView({super.key, required this.singleCategoryModel});

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
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
                    '${singleCategoryModel.image}',
                    height: 350,
                    width: 350,
                  ),
                  // FadeInImage.memoryNetwork(
                  //     placeholder: kTransparentImage,
                  //     image: '${singleCategoryModel.image}',
                  //     height: 350,
                  //     width: 350),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RatingBar.builder(
                        initialRating:
                            cubit.ratingCounter[singleCategoryModel.id] ?? 0,
                        allowHalfRating: true,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (double value) {
                          cubit.ratingItemCounter(singleCategoryModel.id, value);
                        },
                        // updateOnDrag: false,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        cubit.ratingCounter[singleCategoryModel.id] == null ||
                                cubit.ratingCounter[singleCategoryModel.id] == 0
                            ? ''
                            : '${cubit.ratingCounter[singleCategoryModel.id]}',
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
                        '${singleCategoryModel.title}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: ()  {
                          bool isCurrentlyFavorite = cubit.isFavorite[singleCategoryModel.id] ?? false;
                          if (isCurrentlyFavorite) {
                            cubit.removeFavorite('${singleCategoryModel.id}');
                            cubit.changeFavoriteProduct(singleCategoryModel.id!);
                            showMessage('Removed from Favorite');
                            // print('تم الحذف من المفضله');
                          } else {
                            cubit.addCFavorite(itemId: '${singleCategoryModel.id}', value: singleCategoryModel);
                            cubit.changeFavoriteProduct(singleCategoryModel.id!);
                            showMessage('Added to Favorite');
                            // print('تم الاضافه الي المفضله');
                          }
                        },
                        icon: cubit.isFavorite[singleCategoryModel.id] ?? false
                            ? const Icon(Icons.favorite, color: Colors.red)
                            : const Icon(Icons.favorite_border),
                      ),
                    ],
                  ),
                  Text(
                    "${singleCategoryModel.description}",
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
                              cubit.minusItemCounter(singleCategoryModel.id);
                            },
                            icon: const Icon(Icons.remove)),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        '${cubit.itemCounters[singleCategoryModel.id] ?? 0}',
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
                              cubit.plusItemCounter(singleCategoryModel.id);
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
                            cubit.addCartList(itemId: '${singleCategoryModel.id}', value:singleCategoryModel );
                            showMessage('Added to cart');
                            // cubit.addCartList(singleCategoryModel.id);
                            // showMessage('Added to cart');
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
                              Routes.instance.push(
                                context: context,
                                widget: const FavoriteScreen(),
                              );
                            }, child: const Text('BUY')),
                      ),
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
      },
    );
  }
}
