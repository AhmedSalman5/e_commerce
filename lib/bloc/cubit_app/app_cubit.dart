import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/dio_hlper/dio.dart';
import 'package:e_commerce_app/models/category_model.dart';
import 'package:e_commerce_app/models/data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/uid.dart';
import 'app_states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


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
   // firebase
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  // get user from firebase
  Map<String, dynamic>? userInformation;
  void getUserData() {
    emit(UserDataLoadingState());
    fireStore.collection('users').doc(uId).get().then((value) {
       userInformation = value.data();
       // print(userInformation);
      emit(UserDataSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(UserDataErrorState(error.toString()));
    });
  }

  // get Category from Firebase
  List<CategoryModel> categoryModel = [];
  Future<List<CategoryModel>> getCategoryView() async {
    final snapshot = await fireStore.collection('categories').get();
    categoryModel =
        snapshot.docs.map((e) => CategoryModel.fromJson(e.data())).toList();
    return categoryModel;
  }

// Edit Image Profile
  File? profileImage;
  final ImagePicker picker = ImagePicker();
  Future<void> getProfileData() async {
    try {
      // استخدام ImagePicker لاختيار صورة
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
      // التحقق من أنه تم اختيار ملف
      if (pickedFile != null) {
        // تحويل XFile إلى File
        profileImage = File(pickedFile.path);
        uploadProfileImage();
        emit(ImageProfileSuccessState());
      }
    } catch (e) {
      print('Error occurred while picking the image: $e');
      emit(ImageProfileErrorState());
    }
  }

  // upload Image
  void uploadProfileImage(){
  firebase_storage
    .FirebaseStorage.instance
    .ref()
    .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
    .putFile(profileImage!)
    .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
      }).catchError((error){});
  })
    .catchError((error){});
    }




  //----------------------------------------------------------------------------

  // Add to Cart List
  Map<String, dynamic> cartList = {};
  void addCartList({required String itemId,required dynamic value}) {
    if (!cartList.containsKey(itemId)) {
      cartList[itemId] = value;
      emit(AddCartLisState());
    }
  }
 // Remove from Cart
  void removeCartList(String itemId) {
    if (cartList.containsKey(itemId)) {
      cartList.remove(itemId);
      emit(RemoveCartLisState());
    }
  }
  // Map<String, dynamic> get _cartList => cartList;
//------------------------------------------------------------------------------
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
  // Add to Favorite
  Map<String, dynamic> favoriteList = {};
  void addCFavorite({required String itemId,required dynamic value}) {
    if (!favoriteList.containsKey(itemId)) {
      favoriteList[itemId] = value;
      emit(AddFavoriteState());
    }
  }
  // Remove from Favorite
  void removeFavorite(String itemId) {
    if (favoriteList.containsKey(itemId)) {
      favoriteList.remove(itemId);
      emit(RemoveFavoriteState());
    }
  }
// Map<String, dynamic> get _favoriteList => favoriteList;
//------------------------------------------------------------------------------

}
