abstract class AppStates{}

class InatialState extends AppStates{}

class GetUserDataLoadingState extends AppStates{}
class GetUserDataSuccessState extends AppStates{}
class GetUserDataErrorState extends AppStates{
  final String error;
  GetUserDataErrorState(this.error);
}

class ChangeIndexState extends AppStates{}
