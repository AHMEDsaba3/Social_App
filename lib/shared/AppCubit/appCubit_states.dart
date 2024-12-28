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

class makeLikeSuccessState extends AppStates{}
class makeLikeErrorState extends AppStates{
  final String error;
  makeLikeErrorState(this.error);
}

class GetAllPostsDataLoadingState extends AppStates{}
class GetAllPostsDataSuccessState extends AppStates{}
class GetAllPostsDataErrorState extends AppStates{
  final String error;
  GetAllPostsDataErrorState(this.error);
}

class CreatePostsLoadingState extends AppStates{}
class CreatePostsSuccessState extends AppStates{}
class CreatePostsErrorState extends AppStates{
  final String error;
  CreatePostsErrorState(this.error);
}

class GetPostLikesSuccessState extends AppStates{}
class GetPostLikesErrorState extends AppStates{
  final String error;
  GetPostLikesErrorState(this.error);
}

class DeletePostSuccessState extends AppStates{}
class DeletePostErrorState extends AppStates{
  final String error;
  DeletePostErrorState(this.error);
}

class AppThemeState extends AppStates{}
