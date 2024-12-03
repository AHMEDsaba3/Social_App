import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            emit(AppRegisterSuccessState());
          },
        ).catchError((e){
          print('...................................................................');
          print(e.toString());
          emit(AppRegisterErrorState(e.toString()));
    });
  }
}
