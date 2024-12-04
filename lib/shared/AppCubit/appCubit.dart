import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Constant/constans.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/AppCubit/appCubit_states.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(InatialState()) {}

  static AppCubit get(context) => BlocProvider.of(context);


  UserModel? model;
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