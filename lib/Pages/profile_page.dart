import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Constant/components.dart';
import 'package:social_app/Constant/constans.dart';
import 'package:social_app/Pages/edit_profile_page.dart';
import 'package:social_app/Pages/login_page.dart';
import 'package:social_app/network/local/cache_helper.dart';
import 'package:social_app/shared/AppCubit/appCubit.dart';
import 'package:social_app/shared/AppCubit/appCubit_states.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit=AppCubit.get(context);
        if(cubit.model!=null) {
          return Scaffold(
            body: SafeArea(
                child: Column(children: [
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
                          child: Container(
                              height: 130,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)
                                ),

                                image: DecorationImage(
                                  image: NetworkImage(cubit.model?.cover ?? ''),
                                  fit: BoxFit.cover,
                                ),)),
                        ),
                      ),
                      Hero(
                        tag: 'pho',
                        child: CircleAvatar(
                          radius: 47,
                          backgroundColor:cubit.isDark?defaultDarkColor:defaultColor,
                          child: CircleAvatar(
                            radius: 45,
                            backgroundImage: NetworkImage(cubit.model?.image ??
                                ''),
                          ),
                        ),
                      )
                    ],
                  ),
                  Text(cubit.model?.name ?? '', style: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge,),
                  SizedBox(height: heightR(1, context),),
                  Text(cubit.model?.bio ?? '', style: Theme
                      .of(context)
                      .textTheme
                      .bodySmall,),
                  SizedBox(height: heightR(5, context),),
                  // Padding(
                  //   padding: EdgeInsets.all(10),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: InkWell(
                  //           onTap: () {},
                  //           child: Column(
                  //             children: [
                  //               Text('100', style: Theme
                  //                   .of(context)
                  //                   .textTheme
                  //                   .bodyMedium),
                  //               Text('Posts', style: Theme
                  //                   .of(context)
                  //                   .textTheme
                  //                   .bodyMedium)
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: InkWell(
                  //           onTap: () {},
                  //           child: Column(
                  //             children: [
                  //               Text('240', style: Theme
                  //                   .of(context)
                  //                   .textTheme
                  //                   .bodyMedium),
                  //               Text('Photos', style: Theme
                  //                   .of(context)
                  //                   .textTheme
                  //                   .bodyMedium)
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: InkWell(
                  //           onTap: () {},
                  //           child: Column(
                  //             children: [
                  //               Text('10K', style: Theme
                  //                   .of(context)
                  //                   .textTheme
                  //                   .bodyMedium),
                  //               Text('Followers', style: Theme
                  //                   .of(context)
                  //                   .textTheme
                  //                   .bodyMedium)
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: InkWell(
                  //           onTap: () {},
                  //           child: Column(
                  //             children: [
                  //               Text('65', style: Theme
                  //                   .of(context)
                  //                   .textTheme
                  //                   .bodyMedium),
                  //               Text('Followings', style: Theme
                  //                   .of(context)
                  //                   .textTheme
                  //                   .bodyMedium)
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: OutlinedButton(onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              5))),
                                  child: Text('Add Photo', style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyMedium,)),
                            ),
                            SizedBox(width: widthR(10, context),),
                            Expanded(
                                child: OutlinedButton(onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => EditProfilePage(),));
                                },
                                  style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              5))),
                                  child: Icon(Icons.edit,color: defaultIconColor,),)
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              5)),
                                      backgroundColor: Colors.red),
                                  onPressed: () {
                                    CacheHelper.removeData(key: 'uId').then((
                                        value) {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginPage(),
                                        ),
                                            (Route<dynamic> route) => false,
                                      );
                                      cubit.resetProfile();
                                      defaultFlutterToast(
                                          massage: 'Sign out done successfully',
                                          state: ToastState.SUCCESS);
                                    },);
                                  },
                                  child: Text('Sign Out',
                                      style: TextStyle(color: Colors.white))),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],)
            ),);
        }else return Center(child: CircularProgressIndicator(),);
      },
    );
  }
}
