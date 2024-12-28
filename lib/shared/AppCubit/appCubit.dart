import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Constant/constans.dart';
import 'package:social_app/Pages/chats_page.dart';
import 'package:social_app/Pages/home_page.dart';
import 'package:social_app/Pages/profile_page.dart';
import 'package:social_app/Pages/setting_page.dart';
import 'package:social_app/models/massage_model.dart';
import 'package:social_app/models/posts_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/AppCubit/appCubit_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InatialState()) {}

  static AppCubit get(context) => BlocProvider.of(context);

  UserModel? model;
  int currentIndex = 0;

  List<Widget> bottomItem = [
    Icon(CupertinoIcons.home),
    Icon(CupertinoIcons.chat_bubble),
    Icon(CupertinoIcons.person),
    Icon(CupertinoIcons.settings),
  ];

  List<Widget> Screens = [HomePage(), ChatsPage(),ProfilePage(),SettingPage()];

  void changeBottomNavBar(int index) {
    if(index == 1){
      getAllUsers();
    }
    currentIndex = index;
    emit(ChangeIndexState());
  }

  void getUserData() {
    emit(GetUserDataLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then(
      (value) {
        print(value.data());
        model = UserModel.fromJson(value.data()!);
        emit(GetUserDataSuccessState());
      },
    ).catchError((e) {
      print(e.toString());
      emit(GetUserDataErrorState(e.toString()));
    });
  }

  List<UserModel> users=[];
  void getAllUsers(){
    emit(GetAllUserDataLoadingState());
    users=[];
      FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((e){
        if(e.data()['uId']!= model?.id)
        users.add(UserModel.fromJson(e.data()));
      });
      emit(GetUserDataSuccessState());
    },).catchError((e){
      print(e.toString());
      emit(GetUserDataErrorState(e.toString()));
    });

  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> pickProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(pickProfileImageSuccessState());
    } else {
      print('no image picked');
      emit(pickProfileImageErrorState());
    }
  }

  File? coverImage;

  Future<void> pickCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(pickCoverImageSuccessState());
    } else {
      print('no image picked');
      emit(pickCoverImageErrorState());
    }
  }
  void updateUserProfile({
    required String userId,
    required String name,
    required String bio,
    required String phone,
    String? imageUrl,
    String? coverUrl,
  }) {
    emit(UpdateUserProfileLoadingState());

    // Prepare data to update
    Map<String, dynamic> updateData = {
      'name': name,
      'bio': bio,
      'phone': phone,
      if (imageUrl != null) 'image': imageUrl,
      if (coverUrl != null) 'cover': coverUrl,
    };
    // Update FireStore document
    FirebaseFirestore.instance.collection('users').doc(userId).update(updateData).then(
          (value) {
            getUserData();
        emit(UpdateUserProfileSuccessState());
      },
    ).catchError((error) {
      print("Error updating profile: $error");
      emit(UpdateUserProfileErrorState(error.toString()));
    });
  }

  void sendMessage({
    required String receiverID,
    required String dateTime,
    required String text,
}){
    MessageModel messageModel=MessageModel(
      dateTime: dateTime,
      receiverID: receiverID,
      senderId: model?.id,
      text: text
    );
    //set sender message
    FirebaseFirestore.instance
    .collection('users')
    .doc(model?.id)
    .collection('chats')
    .doc(receiverID)
    .collection('messages')
    .add(messageModel.toMap())
    .then((value) {
      emit(sendMessageSuccessState());
    },)
    .catchError((e){
      emit(sendMessageErrorState());
    });

    //set receiver message
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverID)
        .collection('chats')
        .doc(model?.id)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(sendMessageSuccessState());
    },)
        .catchError((e){
      emit(sendMessageErrorState());
    });
  }

  List<MessageModel> messages=[];
  void getMessage(
  {required String receiverId}
      ){
    FirebaseFirestore.instance
        .collection('users')
        .doc(model?.id)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages=[];
          event.docs.forEach((element) {
            messages.add(MessageModel.fromJson(element.data()));
            print(messages);
          },);
        },);
    emit(getMessageSuccessState());
  }

  void createPost({required String text,required String image,required String dateTime}){
    emit(CreatePostsLoadingState());
    PostsModel postsModel =PostsModel(text: text,postImage: image,dateTime: dateTime,name: model?.name,uId: model?.id,image: model?.image);
    FirebaseFirestore.instance.collection('posts')
    .add(postsModel.toMap())
    .then((value) {
      emit(CreatePostsSuccessState());
    },).catchError((e){
      emit(CreatePostsErrorState(e.toString()));
    });

  }
  List<PostsModel> posts=[];
  List<String> postsId=[];
  List<int> likes=[];
  Map<String, bool> likedPosts = {}; // Track liked posts

  void getAllPosts() {
    emit(GetAllPostsDataLoadingState());
    FirebaseFirestore.instance.collection('posts')
        .get()
        .then((value) {
      posts = []; // Clear previous posts
      postsId = []; // Clear previous post IDs
      likes = []; // Clear previous likes
      value.docs.forEach((element) {
        posts.add(PostsModel.fromJson(element.data()));
        postsId.add(element.id);
        getPostLikes(element.id); // Fetch likes for each post
      });
      emit(GetAllPostsDataSuccessState());
    },).catchError((e) {
      emit(GetAllPostsDataErrorState(e.toString()));
    });
  }

  void getPostLikes(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .get()
        .then((value) {
      likes.add(value.docs.length);
      likedPosts[postId] = value.docs.any((doc) => doc.id == model?.id);
      emit(GetPostLikesSuccessState());
    }).catchError((e) {
      emit(GetPostLikesErrorState(e.toString()));
    });
  }

  void likePost(String postId) {
    final isLiked = likedPosts[postId] ?? false;

    if (isLiked) {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('likes')
          .doc(model?.id)
          .delete()
          .then((value) {
        likes[postsId.indexOf(postId)] -= 1;
        likedPosts[postId] = false;
        emit(makeLikeSuccessState());
      }).catchError((e) {
        emit(makeLikeErrorState(e.toString()));
      });
    } else {
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('likes')
          .doc(model?.id)
          .set({'like': true}).then((value) {
        likes[postsId.indexOf(postId)] += 1;
        likedPosts[postId] = true;
        emit(makeLikeSuccessState());
      }).catchError((e) {
        emit(makeLikeErrorState(e.toString()));
      });
    }
  }

  void resetProfile() {
    model = null;
    emit(InatialState());
  }

}
