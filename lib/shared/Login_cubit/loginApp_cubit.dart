import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/Login_cubit/loginApp_states.dart';

class AppLoginCubit extends Cubit<AppLoginStates> {
  AppLoginCubit() : super(InitialAppLoginState());

  static AppLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({required String email, required String password}) {
    emit(AppLoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then(
          (value) {
            print('--------------------------------');
            print(value.user!.email);
            print(value.user!.uid);
            emit(AppLoginSuccessState());
          },
        ).catchError((e){
          print(e.toString());
          emit(AppLoginErrorState(e.toString()));
    });
  }
}
