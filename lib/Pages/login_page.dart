import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Constant/components.dart';
import 'package:social_app/Constant/constans.dart';
import 'package:social_app/Layout/main_page.dart';
import 'package:social_app/Pages/register_page.dart';
import 'package:social_app/network/local/cache_helper.dart';
import 'package:social_app/shared/AppCubit/appCubit.dart';
import 'package:social_app/shared/Login_cubit/loginApp_cubit.dart';
import 'package:social_app/shared/Login_cubit/loginApp_states.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppLoginCubit, AppLoginStates>(
        listener: (context, state) {
          if (state is AppLoginSuccessState) {

            defaultFlutterToast(
                massage: 'Login Success', state: ToastState.SUCCESS);
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(),
              ),
            );
            },);
            uId = state.uId;
            AppCubit.get(context).getUserData();
          } else if (state is AppLoginErrorState) {
            defaultFlutterToast(massage: state.error, state: ToastState.ERROR);
          }
        },
        builder: (context, state)
    {
      AppLoginCubit cubit = AppLoginCubit.get(context);
      return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child: Image.asset(
                    'assets/social logo.png',
                    height: heightR(200, context),
                    width: widthR(200, context),
                  ),
                ),
                Container(
                  width: widthR(350, context),
                  height: heightR(430, context),
                  decoration: BoxDecoration(
                    color: AppCubit.get(context).isDark?defaultDarkColor:defaultColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                        Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(sizeR(20, context)),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(sizeR(20, context)),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Text(
                            'Login Page',
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge,
                          ),
                          SizedBox(
                            height: heightR(30, context),
                          ),
                          defaultTextForm(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            context: context,
                            Controller: emailController,
                            label: 'Email',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: heightR(10, context),
                          ),
                          defaultTextForm(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            context: context,
                            sufIcon: isPasswordVisible
                                ? CupertinoIcons.eye_slash_fill
                                : CupertinoIcons.eye_fill,
                            suffixPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            Controller: passwordController,
                            label: 'Password',
                            keyboardType: TextInputType.visiblePassword,
                            ispassword: !isPasswordVisible,
                          ),
                          SizedBox(
                            height: heightR(15, context),
                          ),
                          state is! AppLoginLoadingState
                              ? ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!
                                  .validate()) {
                                cubit.userLogin(
                                    email: emailController.text,
                                    password:
                                    passwordController.text);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: defaultIconColor,
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                              : CircularProgressIndicator(color: defaultColor,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don\'t have an account?'),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RegisterPage(),
                                    ),
                                  );
                                },
                                child: Text('Register'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
    );
  }
}
