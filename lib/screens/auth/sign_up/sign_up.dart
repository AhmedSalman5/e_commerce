import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/bloc/cubit_auth/auth_cubit.dart';
import 'package:e_commerce_app/constants/uid.dart';
import 'package:e_commerce_app/screens/home/home.dart';
import 'package:e_commerce_app/shared_preferences/shared_preferences.dart';
import 'package:e_commerce_app/widgets/primary_button.dart';
import 'package:e_commerce_app/widgets/top_titles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/cubit_auth/auth_states.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AuthCubit.get(context);
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (BuildContext context, AuthStates state) {
        if (state is RegisterSuccessState) {
          CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
            print('uId = $uId taha');
              Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const Home()));
          });
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
                  title: 'Create Account',
                  subtitle: 'Welcome Back To E Commerce App',
                ),
                const SizedBox(
                  height: 46,
                ),
                Form(
                  key: cubit.formRegisterKey,
                  child: Column(
                    children: [
                          TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    controller: cubit.name,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: const TextStyle(
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.person),
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
                        return 'Please enter email';
                      }
                      return null;
                    },
                    controller: cubit.email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      labelStyle: const TextStyle(
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.lock),
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
                        return 'Please enter your phone';
                      }
                      return null;
                    },
                    controller: cubit.phone,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      labelStyle: const TextStyle(
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.phone),
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
                        return 'Please enter your Password';
                      }else if (value.length < 8){
                        return 'Password is too short';
                      }
                      return null;
                    },
                    controller: cubit.password,
                    obscureText: cubit.isVisibleSignUp,
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
                          cubit.changeVisibleSignUp();
                        },
                        icon: cubit.isVisibleSignUp
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
                      builder: (BuildContext context) => PrimaryButton(
                        title: 'Create Account',
                        onPress: () {
                          cubit.formRegisterValidate();
                        },
                      ),
                      fallback: (BuildContext context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  // PrimaryButton(
                  //   title: 'Create Account',
                  //   onPress: () {
                  //     Routes.instance
                  //         .pushAndRemoveUntil(context: context, widget: Home());
                  //   },
                  // ),
                  
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Center(
                  child: Text('I have already an account'),
                ),
                const SizedBox(
                  height: 12,
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Login'),
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
