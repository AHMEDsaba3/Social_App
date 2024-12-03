abstract class AppLoginStates{}
class InitialAppLoginState extends AppLoginStates{}


class AppLoginLoadingState extends AppLoginStates{}
class AppLoginSuccessState extends AppLoginStates{}
class AppLoginErrorState extends AppLoginStates{
  final String error;
  AppLoginErrorState(this.error);
}