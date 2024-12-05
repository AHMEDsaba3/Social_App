import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Constant/constans.dart';
import 'package:social_app/Pages/chats_page.dart';
import 'package:social_app/Pages/home_page.dart';
import 'package:social_app/Pages/profile_page.dart';
import 'package:social_app/Pages/users_page.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/AppCubit/appCubit_states.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(InatialState()) {}

  static AppCubit get(context) => BlocProvider.of(context);


  UserModel? model;
  int currentIndex=0;

  List<Widget> bottomItem=[
    Icon(CupertinoIcons.home),
    Icon(CupertinoIcons.chat_bubble),
    Icon(CupertinoIcons.person_3),
    Icon(CupertinoIcons.person),

  ];

  List<Widget> Screens=[
    HomePage(),
    ChatsPage(),
    UsersPage(),
    ProfilePage()
  ];

  void changeBottomNavBar(int index){
    currentIndex= index;
    emit(ChangeIndexState());
  }
  void getUserData(){
    emit(GetUserDataLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      model=UserModel.fromJson(value.data()!);
      emit(GetUserDataSuccessState());
    },).catchError((e){
      print(e.toString());
      emit(GetUserDataErrorState(e.toString()));
    });
  }
}