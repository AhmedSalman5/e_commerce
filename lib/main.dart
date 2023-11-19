import 'package:e_commerce_app/bloc/bloc_observer.dart';
import 'package:e_commerce_app/bloc/cubit_app/app_cubit.dart';
import 'package:e_commerce_app/bloc/cubit_auth/auth_cubit.dart';
import 'package:e_commerce_app/constants/theme.dart';
import 'package:e_commerce_app/dio_hlper/dio.dart';
import 'package:e_commerce_app/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:e_commerce_app/shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/cubit_app/app_states.dart';
import 'constants/uid.dart';
import 'screens/auth/welcome/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper.init();
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

  DioHelper.init();
  Bloc.observer = MyBlocObserver();


   uId = (await CacheHelper.getData(key: 'uId') as String?);
  if (uId != null) {
    print('${uId}tmm');
  } else {
    print('uId is null');
  }

  Widget widget = uId != null ? const CustomBottomBar() : const Welcome();
  runApp(MyApp(
    startWidget: widget,
  ));
}


class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({super.key, required this.startWidget});
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
            ..getCategoryView()
            ..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ciseco',
          theme: themeData,
          home: startWidget,
        ),
      ),
    );
  }
}
