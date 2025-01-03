import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Constant/constans.dart';
import 'package:social_app/Layout/main_page.dart';
import 'package:social_app/Pages/login_page.dart';
import 'package:social_app/Pages/onBoarding_page.dart';
import 'package:social_app/Style/theme.dart';
import 'package:social_app/network/local/cache_helper.dart';
import 'package:social_app/network/remote/dio_hellper.dart';
import 'package:social_app/shared/AppCubit/appCubit.dart';
import 'package:social_app/shared/AppCubit/appCubit_states.dart';
import 'package:social_app/shared/BlocObserver.dart';
import 'package:social_app/shared/Login_cubit/loginApp_cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHellper.init();
  await CacheHelper.init();
  Widget widget;
  bool onBoarding=CacheHelper.getData(key: 'onBoarding')??false;
  uId=CacheHelper.getData(key: 'uId')??'';

  if(onBoarding != false){
    if(uId != ''){
      widget=MainPage();
    }else widget=LoginPage();
  }else widget=OnBoardingPage();

  runApp( MyApp(widget: widget,));
}

class MyApp extends StatelessWidget {
  final Widget widget;
   MyApp({super.key,required this.widget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context) => AppLoginCubit(),),
        BlocProvider(create: (context) => AppCubit()..getUserData()..getAllPosts(),)
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Social App',
            theme:AppCubit.get(context).isDark?darkTheme:lightTheme,
            debugShowCheckedModeBanner: false,
            home:widget,
          ) ;
        },
      ),
    );
  }
}
