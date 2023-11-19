import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/uid.dart';
import '../../models/user_model.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);

//----------------------------------------------------------------
  bool isVisibleLogin = true;
  void changeVisibleLogin() {
    isVisibleLogin = !isVisibleLogin;
    emit(ChangeVisiblePasswordLogin());
  }

  bool isVisibleSignUp = true;
  void changeVisibleSignUp() {
    isVisibleSignUp = !isVisibleSignUp;
    emit(ChangeVisiblePasswordSignUp());
  }

//----------------------------------------------------------------
  //------------------------------------------------------------------------------
  // LOGIN
  var formLoginKey = GlobalKey<FormState>();

  void formLoginValidate() {
    if (formLoginKey.currentState!.validate()) {
      print(emailController.text);
      print(passwordController.text);
      userLogin(
        email: emailController.text,
        password: passwordController.text,
      );
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //------------------------------------------------------------------------------
  // Register
  var formRegisterKey = GlobalKey<FormState>();

  void formRegisterValidate() {
    if (formRegisterKey.currentState!.validate()) {
      print(name.text);
      print(email.text);
      print(phone.text);
      print(password.text);
      userRegister(
        name: name.text,
        email: email.text,
        phone: phone.text,
        password: password.text,
      );
    }
  }

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  //------------------------------------------------------------------------------
  // Function Login & Register
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print('تم تسجيل الدخول');
      print(value.user!.uid);
      if (value.user?.uid != null) {
        emit(LoginSuccessState(value.user!.uid));
      }
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

//---------------------------------
  void userRegister({
    required name,
    required email,
    required phone,
    required password,

  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      //print(value.user!.email);
      //print(value.user!.uid);
      userCreate(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
        isEmailVerified: false,
      );
      emit(RegisterSuccessState(value.user!.uid));
    }).catchError((error) {
      print(error);
      emit(RegisterErrorState(error.toString()));
    });
  }
  //------------------------------------------------------------------------------
  //------------------------------------------------------------------------------
  //------------------------------------------------------------------------------
  //------------------------------------------------------------------------------
  //------------------------------------------------------------------------------

  // Create User
  void userCreate({
    required name,
    required email,
    required phone,
    required uId,
    required isEmailVerified,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNZ64eVx7NWbXzGZA4HOCFluiDfHx1gdVh-A&usqp=CAU',
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(
          model.toMap(),
        )
        .then((value) {
      print('تم انشاء حساب');
      emit(CreateUserSuccessState(
        uId
      ));
    }).catchError((error) {
      print(error.toString());
      emit(CreateUserErrorState(error));
    });
  }

  //----------------------------------------------------------------------------

  // Future<void> signOut(context) async {
  //   try {
  //     await FirebaseAuth.instance.signOut();
  //     // Routes.instance.pushAndRemoveUntil(
  //     //     context: context, widget: const Welcome());
  //     // emit(SignOutState());
  //   } catch (error) {
  //     print("Error signing out: $error");
  //     emit(ErrorSignOutState(error.toString()));
  //   }
  // }


  //----------------------------------------------------------------------------

}

