import 'package:e_commerce_app/bloc/cubit_auth/auth_cubit.dart';
import 'package:e_commerce_app/constants/routes.dart';
import 'package:e_commerce_app/screens/auth/sign_up/sign_up.dart';
import 'package:e_commerce_app/widgets/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/cubit_auth/auth_states.dart';
import '../../../widgets/primary_button.dart';
import '../login/login.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopTitles(
                  title: 'Welcome',
                  subtitle: 'Buy Any Item From Using App',
                ),
                Center(
                  child: Image.asset(
                    'assets/images/welcome.png',
                    alignment: Alignment.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      child: const Icon(
                        Icons.facebook,
                        size: 35,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    CupertinoButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      child: Image.asset(
                        'assets/images/google.png',
                        scale: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                PrimaryButton(
                  title: 'Login',
                  onPress: () {
                    Routes.instance.push(context: context, widget: const Login());
                  },
                ),
                const SizedBox(
                  height: 18,
                ),
                PrimaryButton(
                  title: 'Sign Up',
                  onPress: () {
                    Routes.instance.push(context: context, widget: const SignUp());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
