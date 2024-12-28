import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Constant/components.dart';
import 'package:social_app/Constant/constans.dart';
import 'package:social_app/shared/AppCubit/appCubit.dart';
import 'package:social_app/shared/AppCubit/appCubit_states.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController();

  TextEditingController bioController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is UpdateUserProfileSuccessState) {
          defaultFlutterToast(
              massage: 'Profile Updated Successfully',
              state: ToastState.SUCCESS);
          Navigator.pop(context);
        } else if (state is UpdateUserProfileErrorState) {
          defaultFlutterToast(
              massage: 'Error updating profile', state: ToastState.ERROR);
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        nameController.text = cubit.model?.name ?? '';
        bioController.text = cubit.model?.bio ?? '';
        phoneController.text = cubit.model?.phone ?? '';
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(CupertinoIcons.back)),
            title: Text(
              'Edit Profile',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            titleSpacing: 5,
            actions: [
              TextButton(
                  onPressed: () {
                    cubit.updateUserProfile(
                        userId: cubit.model!.id!,
                        name: nameController.text,
                        phone:phoneController.text,
                        bio: bioController.text);
                  },
                  child: Text(
                    'Update',
                    style: Theme.of(context).textTheme.bodyMedium,
                  )),
              SizedBox(
                width: 10,
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Container(
                      color: cubit.isDark?defaultDarkColor:defaultColor,
                      height: heightR(170, context),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                                height: 130,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  image: DecorationImage(
                                    image: cubit.coverImage != null
                                        ? FileImage(cubit.coverImage!)
                                        : NetworkImage(
                                            cubit.model?.cover ?? ''),
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            IconButton(
                                onPressed: () {
                                  cubit.pickCoverImage();
                                },
                                icon: Icon(CupertinoIcons.camera_circle_fill))
                          ],
                        ),
                      ),
                    ),
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Hero(
                          tag: 'pho',
                          child: CircleAvatar(
                            radius: 47,
                            backgroundColor:cubit.isDark?defaultDarkColor:defaultColor,
                            child: CircleAvatar(
                              radius: 45,
                              backgroundImage: cubit.profileImage != null
                                  ? FileImage(cubit.profileImage!)
                                  : NetworkImage(cubit.model?.image ?? ''),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              cubit.pickProfileImage();
                            },
                            icon: Icon(
                                size: 30, CupertinoIcons.camera_circle_fill))
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: heightR(20, context),
                ),
                defaultTextForm(
                    context: context,
                    Controller: nameController,
                    label: 'Edit name',
                    keyboardType: TextInputType.name,
                    radius: 10),
                SizedBox(
                  height: heightR(15, context),
                ),
                defaultTextForm(
                    context: context,
                    Controller: bioController,
                    label: 'Edit bio',
                    keyboardType: TextInputType.text,
                    radius: 10),
                SizedBox(
                  height: heightR(15, context),
                ),
                defaultTextForm(
                    context: context,
                    Controller: phoneController,
                    label: 'Edit Phone',
                    keyboardType: TextInputType.phone,
                    radius: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
