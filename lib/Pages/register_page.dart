import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Constant/components.dart';
import 'package:social_app/Constant/constans.dart';
import 'package:social_app/Layout/main_page.dart';
import 'package:social_app/Pages/login_page.dart';
import 'package:social_app/network/local/cache_helper.dart';
import 'package:social_app/shared/AppCubit/appCubit.dart';
import 'package:social_app/shared/Register_cubit/register_cubit.dart';
import 'package:social_app/shared/Register_cubit/register_states.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppRegisterCubit(),
      child: BlocConsumer<AppRegisterCubit,AppRegisterStates>(
        listener: (context, state) {
          if (state is AppUserCreateSuccessState) {
            FirebaseAuth.instance.currentUser!.sendEmailVerification();
            defaultFlutterToast(massage:'Register Success',state: ToastState.SUCCESS );
              CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPage(),
                  ),
                );
                AppCubit.get(context).getUserData();
              },);
              uId = state.uId;
            } else if(state is AppRegisterErrorState) {
              defaultFlutterToast(massage:state.error,state: ToastState.ERROR );
            }
        },
        builder: (context, state) {
          AppRegisterCubit cubit=AppRegisterCubit.get(context);
          return Scaffold(

            body: SingleChildScrollView(
              child: SafeArea(
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Hero(
                            tag: 'logo',
                            child: Image(
                              image: AssetImage('assets/social logo1.png'),
                              height: heightR(200, context),
                              width: widthR(200, context),
                            ),
                          ),
                          Container(
                            width: widthR(350, context),
                            height: heightR(550, context),
                            decoration: BoxDecoration(
                                color: AppCubit.get(context).isDark?defaultDarkColor:defaultColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(sizeR(20, context)),
                                )),
                            child: Padding(
                              padding: EdgeInsets.all(sizeR(20, context)),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    Text(
                                      'SignUp Page',
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    SizedBox(
                                      height: heightR(30, context),
                                    ),
                                    defaultTextForm(
                                        sufIcon: Icons.person,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your name';
                                          }
                                          return null;
                                        },
                                        context: context,
                                        Controller: nameController,
                                        label: 'name',
                                        keyboardType: TextInputType.name),
                                    SizedBox(
                                      height: heightR(10, context),
                                    ),
                                    defaultTextForm(
                                        sufIcon: Icons.phone_android,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your phone';
                                          }
                                        },
                                        context: context,
                                        Controller: phoneController,
                                        label: 'Phone',
                                        keyboardType: TextInputType.phone),
                                    SizedBox(
                                      height: heightR(10, context),
                                    ),
                                    defaultTextForm(
                                        sufIcon: Icons.email,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your email';
                                          }
                                          return null;
                                        },
                                        context: context,
                                        Controller: emailController,
                                        label: 'Email',
                                        keyboardType: TextInputType.emailAddress),
                                    SizedBox(
                                      height: heightR(10, context),
                                    ),
                                    defaultTextForm(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your password';
                                        }
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
                                      label: 'password',
                                      keyboardType: TextInputType.visiblePassword,
                                      ispassword: !isPasswordVisible,),
                                    SizedBox(
                                      height: heightR(15, context),
                                    ),
                                    SizedBox(
                                      height: heightR(15, context),
                                    ),
                                    state is! AppRegisterLoadingState ?
                                    ElevatedButton(
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            cubit.userRegister(
                                                name: nameController.text,
                                                phone: phoneController.text,
                                                email: emailController.text,
                                                password:
                                                passwordController.text);
                
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: defaultIconColor),
                                        child: Text(
                                          'SignUp',
                                          style: TextStyle(color: Colors.white),
                                        )) : CircularProgressIndicator(color: defaultColor,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Have an account ?'),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => LoginPage(),
                                                  ));
                                            },
                                            child: Text('Login'))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: heightR(30, context),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SafeArea(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(onPressed: () {
                            Navigator.pop(context);
                          }, icon: Icon(CupertinoIcons.back)),),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
