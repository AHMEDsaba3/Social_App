abstract class AppStates{}

class InatialState extends AppStates{}

class GetUserDataLoadingState extends AppStates{}
class GetUserDataSuccessState extends AppStates{}
class GetUserDataErrorState extends AppStates{
  final String error;
  GetUserDataErrorState(this.error);
}
class GetAllUserDataLoadingState extends AppStates{}
class GetAllUserDataSuccessState extends AppStates{}
class GetAllUserDataErrorState extends AppStates{
  final String error;
  GetAllUserDataErrorState(this.error);
}

class ChangeIndexState extends AppStates{}

class pickProfileImageSuccessState extends AppStates{}
class pickProfileImageErrorState extends AppStates{}
class pickCoverImageSuccessState extends AppStates{}
class pickCoverImageErrorState extends AppStates{}

class UpdateUserProfileLoadingState extends AppStates{}
class UpdateUserProfileSuccessState extends AppStates{}
class UpdateUserProfileErrorState extends AppStates{
  final String error;
  UpdateUserProfileErrorState(this.error);
}
class sendMessageSuccessState extends AppStates{}
class sendMessageErrorState extends AppStates{}

class getMessageSuccessState extends AppStates{}
class getMessageErrorState extends AppStates{}