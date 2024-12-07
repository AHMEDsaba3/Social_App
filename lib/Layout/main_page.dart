import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Constant/components.dart';
import 'package:social_app/Constant/constans.dart';
import 'package:social_app/Pages/login_page.dart';
import 'package:social_app/network/local/cache_helper.dart';
import 'package:social_app/shared/AppCubit/appCubit.dart';
import 'package:social_app/shared/AppCubit/appCubit_states.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit=AppCubit.get(context);
        return Scaffold(
          body: cubit.Screens[cubit.currentIndex],
          bottomNavigationBar:  CurvedNavigationBar(
            key: _bottomNavigationKey,
            buttonBackgroundColor: secondColor,
            backgroundColor: Colors.black12,
            animationCurve: Curves.easeIn,
            items: cubit.bottomItem,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
          ),
        );
        },
    );
  }
}
