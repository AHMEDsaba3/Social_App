abstract class AppStates{}

class InatialState extends AppStates{}

class GetUserDataLoadingState extends AppStates{}
class GetUserDataSuccessState extends AppStates{}
class GetUserDataErrorState extends AppStates{
  final String error;
  GetUserDataErrorState(this.error);
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
