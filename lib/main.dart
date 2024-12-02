import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:social_app/Constant/constans.dart';
import 'package:social_app/Layout/main_page.dart';
import 'package:social_app/Pages/login_page.dart';
import 'package:social_app/Pages/onBoarding_page.dart';
import 'package:social_app/Style/theme.dart';
import 'package:social_app/network/local/cache_helper.dart';
import 'package:social_app/network/remote/dio_hellper.dart';
import 'package:social_app/shared/BlocObserver.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHellper.init();
  await CacheHelper.init();
  Widget widget;
  bool onBoarding=CacheHelper.getData(key: 'onBoarding')??false;
  token=CacheHelper.getData(key: 'token')??'';

  if(onBoarding != false){
    if(token != ''){
      widget=MainPage();
    }else widget=LoginPage();
  }else widget=OnBoardingPage();

  runApp( MyApp(widget: widget,));
}

class MyApp extends StatelessWidget {
  final Widget widget;
  const MyApp({super.key,required this.widget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:lightTheme,
      home:widget,
    );
  }
}
