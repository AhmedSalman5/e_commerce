import 'package:e_commerce_app/bloc/cubit_app/app_cubit.dart';
import 'package:e_commerce_app/bloc/cubit_app/app_states.dart';
import 'package:e_commerce_app/constants/routes.dart';
import 'package:e_commerce_app/models/data_model.dart';
import 'package:e_commerce_app/screens/product_details/product_details.dart';
import 'package:e_commerce_app/widgets/screen_builder.dart';
import 'package:e_commerce_app/widgets/top_titles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var categoryModel = AppCubit.get(context).categoryModel;
    var cubit = AppCubit.get(context);
    var list = AppCubit.get(context).productList;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) => Scaffold(
        body:
        cubit.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            :
            SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TopTitles(
                            title: 'Ciseco',
                            subtitle: '',
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Search...',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const Text(
                            'Categories',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    screenBuilder(categoryModel),
                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'Best Products',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: list.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 0.72,
                        ),
                        itemBuilder: ((context, index) {
                          Product singleProduct = list[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 7),
                                  child: Image.network(singleProduct.images![0],
                                      height: 70, width: 70),
                                  // FadeInImage.memoryNetwork(
                                  //     placeholder: kTransparentImage,
                                  //     image: singleProduct.images![0],
                                  //     height: 70,
                                  //     width: 70),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: Text(
                                    '${singleProduct.title}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                Text('Price: \$${singleProduct.price}'),
                                const SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                  height: 45,
                                  width: 140,
                                  child: OutlinedButton(
                                      onPressed: () {
                                        Routes.instance.push(
                                            context: context,
                                            widget: ProductDetails(
                                              singleProduct: singleProduct,
                                            ));
                                      },
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.green,
                                        side: const BorderSide(
                                          color: Colors.green,
                                          width: 1.7,
                                        ),
                                      ),
                                      child: const Text(
                                        'Buy',
                                      )),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
