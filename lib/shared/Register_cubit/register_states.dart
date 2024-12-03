abstract class AppRegisterStates{}

class InitialAppRegisterState extends AppRegisterStates{}

class AppRegisterLoadingState extends AppRegisterStates{}
class AppRegisterSuccessState extends AppRegisterStates{}
class AppRegisterErrorState extends AppRegisterStates{
  final String error;
  AppRegisterErrorState(this.error);
}