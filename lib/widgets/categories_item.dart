import 'package:e_commerce_app/constants/routes.dart';
import 'package:e_commerce_app/models/category_model.dart';
import 'package:e_commerce_app/screens/category_view/category_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildArticleItem(categoryModel, context) => Container(
      height: 100,
      color: Colors.white,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          CategoryModel singleCategory = categoryModel[index];
          return Padding(
            padding: const EdgeInsets.only(left: 8),
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Routes.instance.push(
                    context: context,
                    widget: CategoryView(singleCategoryModel: singleCategory));
              },
              child: Card(
                  color: Colors.white,
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: "${singleCategory.image}",
                          height: 70,
                          width: 70,
                        ),
                      ),
                    ),
                  )),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          width: 8,
        ),
        itemCount: categoryModel.length,
      ),
    );
