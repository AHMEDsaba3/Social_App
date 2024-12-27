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
    if(users.isEmpty) {
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
    //we cant use this to cant write if condition before cover and image and we need to update specific data
    // UserModel model = UserModel(
    //     bio: bio,
    //     name: name,
    //     cover: coverUrl,
    //     image: imageUrl,);
    // Update Firestore document
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

  //
  // void uploadProfileImage(File image) {
  //   FirebaseStorage.instance
  //       .ref()
  //       .child('users/${Uri.file(image!.path).pathSegments.last}')
  //       .putFile(image!).then((p0) {
  //         p0.ref.getDownloadURL().then((value) {
  //           print(value);
  //         },).catchError(onError);
  //       },).catchError(onError);
  // }

  // Future<String> uploadProfileImage(File image) async {
  //   try {
  //     // Upload the image to Firebase Storage and get the download URL
  //     final ref = FirebaseStorage.instance
  //         .ref()
  //         .child('users/${Uri.file(image.path).pathSegments.last}');
  //
  //     // Perform the upload
  //     final uploadTask = await ref.putFile(image);
  //
  //     // Once uploaded, retrieve the download URL
  //     String downloadUrl = await uploadTask.ref.getDownloadURL();
  //
  //     print(downloadUrl);
  //     return downloadUrl;
  //   } catch (e) {
  //     print("Error uploading image: $e");
  //     throw e; // You can handle the error here as needed
  //   }
  // }

  void resetProfile() {
    model = null;
    emit(InatialState());
  }

}
