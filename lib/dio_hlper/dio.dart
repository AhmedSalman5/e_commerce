import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://dummyjson.com/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future <Response?> getData(
      {required String url, required Map<String, dynamic> query}) async {
    return await dio?.get(url, queryParameters: query);
  }
}

// api data
// https://dummyjson.com/products



// {
//   "id":1,
//   "title":"iPhone 9",
//   "description":"An apple mobile which is nothing like apple",
//   "price":549,
//   "discountPercentage":12.96,
//   "rating":4.69,
//   "stock":94,
//   "brand":"Apple",
//   "category":"smartphones",
//   "thumbnail":"https://i.dummyjson.com/data/products/1/thumbnail.jpg",
//   "images":[
//     "https://i.dummyjson.com/data/products/1/1.jpg",
//     "https://i.dummyjson.com/data/products/1/2.jpg",
//     "https://i.dummyjson.com/data/products/1/3.jpg",
//     "https://i.dummyjson.com/data/products/1/4.jpg",
//     "https://i.dummyjson.com/data/products/1/thumbnail.jpg"
//           ]
//     }