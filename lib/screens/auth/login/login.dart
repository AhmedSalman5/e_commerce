import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/bloc/cubit_auth/auth_cubit.dart';
import 'package:e_commerce_app/constants/routes.dart';
import 'package:e_commerce_app/screens/auth/sign_up/sign_up.dart';
import 'package:e_commerce_app/screens/home/home.dart';
import 'package:e_commerce_app/widgets/primary_button.dart';
import 'package:e_commerce_app/widgets/top_titles.dart';
import 'package:e_commerce_app/widgets/tost_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/cubit_auth/auth_states.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AuthCubit.get(context);
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (BuildContext context, AuthStates state) {
        if (state is LoginErrorState) {
          showMessage(state.error);
        }
        // if (state is LoginSuccessState) {
        //   CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
        //     print('uId = ${UserId.uId} taha');
        //     Navigator.pushReplacement(
        //         context, MaterialPageRoute(builder: (context) => const Home()));
        //   });
        // }
        if (state is LoginSuccessState) {
          Routes.instance.pushAndRemoveUntil(
            context: context,
            widget: const Home(),
          );
        }
      },
      builder: (BuildContext context, AuthStates state) => Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopTitles(
                  title: 'Login',
                  subtitle: 'Welcome Back To E Commerce App',
                ),
                Form(
                  key: cubit.formLoginKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 46,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the email';
                          }
                          return null;
                        },
                        controller: cubit.emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          labelStyle: const TextStyle(
                            fontSize: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.email),
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the Password';
                          }
                          return null;
                        },
                        controller: cubit.passwordController,
                        obscureText: cubit.isVisibleLogin,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: const TextStyle(
                            fontSize: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              cubit.changeVisibleLogin();
                            },
                            icon: cubit.isVisibleLogin
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        height: 45,
                        width: double.infinity,
                        child: ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (
                            BuildContext context,
                          ) =>
                              PrimaryButton(
                            title: 'Login',
                            onPress: () {
                              cubit.formLoginValidate();
                            },
                          ),
                          fallback: (BuildContext context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                ),
                const Center(
                  child: Text('Don\'t have an account?'),
                ),
                const SizedBox(
                  height: 12,
                ),
                Center(
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Routes.instance.push(
                        context: context,
                        widget: const SignUp(),
                      );
                    },
                    child: const Text('Create an account'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
