import 'package:e_commerce_app/bloc/bloc_observer.dart';
import 'package:e_commerce_app/bloc/cubit_app/app_cubit.dart';
import 'package:e_commerce_app/bloc/cubit_auth/auth_cubit.dart';
import 'package:e_commerce_app/constants/theme.dart';
import 'package:e_commerce_app/constants/uid.dart';
import 'package:e_commerce_app/dio_hlper/dio.dart';
import 'package:e_commerce_app/screens/home/home.dart';
import 'package:e_commerce_app/screens/on_boarding/on_boading.dart';
import 'package:e_commerce_app/shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/cubit_app/app_states.dart';
import 'screens/auth/welcome/welcome.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Android
    options: const FirebaseOptions(
      apiKey: "AIzaSyBNVqIRR_u9BUchSWii2OYtmBJNDcU7UCQ",
      appId: "1:210594443624:android:0ecf33a677ac5bc63b66dd",
      messagingSenderId: "210594443624",
      projectId: "e-commerce-app-bb498",
    ),
  );
  await Firebase.initializeApp(
    // ios
    options: const FirebaseOptions(
      apiKey: "AIzaSyBNVqIRR_u9BUchSWii2OYtmBJNDcU7UCQ",
      appId: "1:210594443624:ios:44b31df376a2eac63b66dd",
      messagingSenderId: "210594443624",
      projectId: "e-commerce-app-bb498",
    ),
  );
  CacheHelper.init();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();


  // to get profile to user
  Widget? widget;
  // uId = CacheHelper.getData(key: 'uId');

  if (uId != null) {
    widget = const Home();
  } else {
    widget = const Welcome();
  }

// if (kIsWeb) {
// setPathUrlStrategy();
// runApp(
//   MyApp(),
// );
  if (true) {
    setPathUrlStrategy();
  runApp(MyApp(
    startWidget: widget,
  ));
  }
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key, required this.startWidget});
  Widget startWidget;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AuthCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..getCategories()
            ..getCategoryView(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ciseco',
          theme: themeData,
          home: OnBoardingScreen(),
        ),
      ),
    );
  }
}
