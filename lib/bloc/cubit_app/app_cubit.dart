import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/dio_hlper/dio.dart';
import 'package:e_commerce_app/models/category_model.dart';
import 'package:e_commerce_app/models/data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_states.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  //----------------------------------------------------------------------------
  // get Data from Api
  bool isLoading = true;
  List<Product> productList = [];
  void getCategories() {
    if (productList.isEmpty) {
      emit(CategoriesLoadingState());
      DioHelper.getData(url: 'products', query: {}).then((value) {
        DataModel dataModel = DataModel.fromJson(value!.data);
        productList = dataModel.products ?? [];
        isLoading = false;
        emit(CategoriesSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(CategoriesErrorState(error));
      });
    }
  }

  //----------------------------------------------------------------------------

// toggle Favorite Product
  Map<dynamic, bool> isFavorite = {};
  void changeFavoriteProduct(var productId) {
    if (isFavorite.containsKey(productId)) {
      isFavorite[productId] = !isFavorite[productId]!;
    } else {
      isFavorite[productId] = true;
    }
    emit(ChangeFavoriteProduct());
  }
  //----------------------------------------------------------------------------

// minus counter of Products
  Map<dynamic, int> itemCounters = {};
  void minusItemCounter(var productId) {
    if (!itemCounters.containsKey(productId)) {
      itemCounters[productId] = 0;
    } else if (itemCounters[productId]! > 0) {
      itemCounters[productId] = itemCounters[productId]! - 1;
    }
    emit(MinusItemCounter());
  }

// plus counter of Products
  void plusItemCounter(var productId) {
    if (!itemCounters.containsKey(productId)) {
      itemCounters[productId] = 0;
    }
    itemCounters[productId] = itemCounters[productId]! + 1;
    emit(PlusItemCounter());
  }

  //----------------------------------------------------------------------------
  //  add Rating
  Map<dynamic, double> ratingCounter = {};

  void ratingItemCounter(var productId, double rating) {
    ratingCounter[productId] = rating;
    emit(RatingItemCounter());
  }
  //----------------------------------------------------------------------------

  // get Category from Firebase
  List<CategoryModel> categoryModel = [];
  Future<List<CategoryModel>> getCategoryView() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final snapshot = await firestore.collection('categories').get();
    categoryModel =
        snapshot.docs.map((e) => CategoryModel.fromJson(e.data())).toList();
    return categoryModel;
  }


  //----------------------------------------------------------------------------
  // Add to Cart List
  List<dynamic> cartList = [];
  void addCartLis(singleCartList) {
    cartList.add(singleCartList);
    emit(AddCartLisState());
  }

  void removeCartLis(singleCartList) {
    cartList.remove(singleCartList);
    emit(RemoveCartLisState());
  }

  List<dynamic> get getCartList => cartList;
}
