import 'package:e_commerce_app/bloc/cubit_app/app_cubit.dart';
import 'package:e_commerce_app/bloc/cubit_app/app_states.dart';
import 'package:e_commerce_app/constants/routes.dart';
import 'package:e_commerce_app/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:e_commerce_app/widgets/primary_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class Checkout extends StatelessWidget {
   final dynamic singleProduct;
   const Checkout({super.key,required this.singleProduct});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context, AppStates state) {  },
      builder: (BuildContext context, AppStates state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: const Text(
              "Checkout",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 36.0,
                ),
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 3.0)),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: cubit.groupValue,
                        onChanged: (value) {
                          cubit.getGroupValue(value);
                        },
                      ),
                      const Icon(Icons.money),
                      const SizedBox(
                        width: 12.0,
                      ),
                      const Text(
                        "Cash on Delivery",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 3.0)),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Radio(
                        value: 2,
                        groupValue: cubit.groupValue,
                        onChanged: (value) {
                          cubit.getGroupValue(value);
                        },
                      ),
                      const Icon(Icons.money),
                      const SizedBox(
                        width: 12.0,
                      ),
                      const Text(
                        "Pay Online",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                PrimaryButton(
                  title: "Continues",
                  onPress: () async {
                    cubit.clearBuyProduct();
                    cubit.addBuyProduct(widget.singleProduct);

                    if (cubit.groupValue == 1) {
                      bool value = await FirebaseFirestoreHelper.instance
                          .uploadOrderedProductFirebase(
                          cubit.getBuyProductList,
                          context,
                          "Cash on delivery");

                      cubit.clearBuyProduct();
                      if (value) {
                        Future.delayed(
                            const Duration(seconds: 2), () {
                          Routes.instance.push(
                              widget: const CustomBottomBar(), context: context);
                        });
                      }
                    } else {
                      int value = double.parse(
                          cubit.totalPriceBuyProductList().toString())
                          .round()
                          .toInt();
                      String totalPrice = (value * 100).toString();
                      await StripeHelper.instance
                          .makePayment(totalPrice.toString(), context);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },

    );
  }
}
