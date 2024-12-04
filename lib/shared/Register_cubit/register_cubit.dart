import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/Register_cubit/register_states.dart';

class AppRegisterCubit extends Cubit<AppRegisterStates> {
  AppRegisterCubit() : super(InitialAppRegisterState());

  static AppRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister(
      {required String name,
      required String phone,
      required String email,
      required String password}) {
    emit(AppRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        print(value.user!.email);
        print(value.user!.uid);
        createUser(name: name, phone: phone, email: email, id: value.user!.uid);
      },
    ).catchError((e) {
      print(
          '...................................................................');
      print(e.toString());
      emit(AppRegisterErrorState(e.toString()));
    });
  }

  void createUser(
      {required String name,
      required String phone,
      required String email,
      required String id}) {
    emit(AppUserCreateLoadingState());
    UserModel model = UserModel(email: email, phone: phone, id: id, name: name,isEmailVerified: false);

    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(model.toMap())
        .then(
      (value) {
        emit(AppUserCreateSuccessState(id));
      },
    ).catchError((e) {
      print(e.toString());
      emit(AppUserCreateErrorState(e.toString()));
    });
  }
}
