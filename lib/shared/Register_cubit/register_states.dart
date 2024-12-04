abstract class AppRegisterStates{}

class InitialAppRegisterState extends AppRegisterStates{}

class AppRegisterLoadingState extends AppRegisterStates{}
class AppRegisterSuccessState extends AppRegisterStates{}
class AppRegisterErrorState extends AppRegisterStates{
  final String error;
  AppRegisterErrorState(this.error);
}

class AppUserCreateLoadingState extends AppRegisterStates{}
class AppUserCreateSuccessState extends AppRegisterStates{
  final String uId;
  AppUserCreateSuccessState(this.uId);
}
class AppUserCreateErrorState extends AppRegisterStates{
  final String error;
  AppUserCreateErrorState(this.error);
}