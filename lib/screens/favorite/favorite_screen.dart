import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/cubit_app/app_cubit.dart';
import '../../bloc/cubit_app/app_states.dart';
import '../../models/data_model.dart';
import '../../widgets/single_favorite_item.dart';
import '../../widgets/tost_message.dart';


class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (BuildContext context, AppStates state) {
        return Scaffold(
          appBar: AppBar(
            // leading: IconButton(
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            //   icon: const Icon(
            //     Icons.arrow_back_ios,
            //   ),
            // ),
            title: const Text(
              'Favorite',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: cubit.favoriteList.isEmpty ? const Center(
            child: Text('Favorite is Empty',style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
              fontWeight: FontWeight.w700,
            ),),
          ) : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: cubit.favoriteList.length,
              itemBuilder: (context, index) {
                String key = cubit.favoriteList.keys.elementAt(index);
                var singleItem = cubit.favoriteList[key]!;
                return SingleFavoriteItem(
                  image: singleItem is Product ? singleItem.images![0] : singleItem.image,
                  title: '${singleItem.title}',
                  price: '${singleItem.price}',
                  removeToWishList: () {
                    cubit.removeFavorite('${singleItem.id}');
                    cubit.changeFavoriteProduct(singleItem.id);
                    showMessage('Removed from Favorite');
                  },
                );
              }),
        );
      },
    );
  }
}
