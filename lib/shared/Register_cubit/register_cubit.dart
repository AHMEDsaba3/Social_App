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
      String? image,
      String? bio,
      String? cover,
      required String password}) {
    emit(AppRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        print(value.user!.email);
        print(value.user!.uid);
        createUser(
            name: name,
            phone: phone,
            bio: bio ?? 'write your bio...',
            image: image ??
                'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?t=st=1733384278~exp=1733387878~hmac=c1a4d14e798cf17e7e131b5d0125aac3a4928490ee3b44e289471cc469779ef1&w=996',
            cover: cover??'https://img.freepik.com/free-photo/modern-futuristic-sci-fi-background_35913-2150.jpg?t=st=1733530672~exp=1733534272~hmac=5084f6dfba2cd40eebebc52438e8dcf7a2a50ffb33fefb1a3b910f4faae8f731&w=996',
            email: email,
            id: value.user!.uid);
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
      required String image,
      required String bio,
      required String cover,
      required String id}) {
    emit(AppUserCreateLoadingState());
    UserModel model = UserModel(
        email: email,
        phone: phone,
        id: id,
        bio: bio,
        name: name,
        cover: cover,
        image: image,
        isEmailVerified: false);

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
