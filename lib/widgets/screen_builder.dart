import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/widgets/categories_item.dart';
import 'package:flutter/material.dart';

Widget screenBuilder(categoryModel) => ConditionalBuilder(
      condition: categoryModel.isNotEmpty,
      builder: (BuildContext context) => buildArticleItem(categoryModel,context),
      fallback: (BuildContext context) =>
          const Center(child: CircularProgressIndicator()),
    );