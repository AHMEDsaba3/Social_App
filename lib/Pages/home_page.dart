import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Constant/components.dart';
import 'package:social_app/Constant/constans.dart';
import 'package:social_app/Pages/add_post_page.dart';
import 'package:social_app/Pages/notification_page.dart';
import 'package:social_app/models/posts_model.dart';
import 'package:social_app/shared/AppCubit/appCubit.dart';
import 'package:social_app/shared/AppCubit/appCubit_states.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        if (cubit.model != null) {
          return Scaffold(
              body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Social App',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Spacer(),
                        CircleAvatar(
                          backgroundColor: secondColor,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NotificationPage(),
                                  ));
                            },
                            icon: Icon(Icons.notifications_none),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: secondColor,
                          radius: 25,
                          backgroundImage:
                              NetworkImage(cubit.model?.image ?? ''),
                        ),
                        SizedBox(
                          width: widthR(10, context),
                        ),
                        SizedBox(
                          height: 40,
                          width: widthR(260, context),
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  alignment: Alignment.centerLeft),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddPostPage(
                                          image: cubit.model?.image ?? '',
                                          name: cubit.model?.name ?? ''),
                                    ));
                              },
                              child: Text(
                                'What is on your mind?..',
                                style: TextStyle(color: Colors.grey),
                              )),
                        ),
                        Spacer(),
                        CircleAvatar(
                          backgroundColor: secondColor,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NotificationPage(),
                                  ));
                            },
                            icon: Icon(
                              Icons.post_add,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: heightR(20, context),
                    ),
                    if (cubit.posts.isNotEmpty)
                      ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            if (index < cubit.posts.length &&
                                index < cubit.postsId.length &&
                                index < cubit.likes.length) {
                              return buildPost(context, cubit.posts[index],
                                  cubit.postsId[index], cubit.likes[index]);
                            } else {
                              return SizedBox();
                            }
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: heightR(20, context),
                            );
                          },
                          itemCount: cubit.posts.length)
                    else
                      Align(
                          child: Text(
                        'no posts are available',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ))
                  ],
                ),
              ),
            ),
          ));
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildPost(context, PostsModel postModel, String postId, int likes) {
    AppCubit cubit = AppCubit.get(context);
    bool isLiked = cubit.likedPosts[postId] ?? false;
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      width: widthR(340, context),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: cubit.isDark?shadowDarkColor:shadowColor,
            blurRadius: 20,
            spreadRadius: -10,
            offset: Offset(10, 7))
      ], color: cubit.isDark?defaultDarkColor:defaultColor, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: secondColor,
                  radius: 35,
                  backgroundImage: NetworkImage(postModel.image ?? nowImage),
                ),
                SizedBox(
                  width: widthR(8, context),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${postModel.name}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      '${postModel.dateTime}',
                      style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                    ),
                  ],
                ),
                Spacer(),
                if(postModel.uId==cubit.model?.id)
                PopupMenuButton(itemBuilder: (context) => [
                  PopupMenuItem(child: Text('delete post'),value: 'delete',)
                ],
                onSelected: (value) {
                  if(value=='delete'){
                    cubit.deletePost(postId);
                  }
                },
                )
                // IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
              ],
            ),
            SizedBox(
              height: heightR(10, context),
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '${postModel.text}',
                  style: Theme.of(context).textTheme.bodySmall,
                )),
            SizedBox(
              height: heightR(10, context),
            ),
            if (postModel.postImage != '')
              Container(
                width: widthR(327, context),
                height: heightR(186, context),
                clipBehavior: Clip.hardEdge,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(postModel.postImage ?? nowImage)),
              ),
            Row(
              children: [
                IconButton(
                    style: ButtonStyle(iconSize: WidgetStatePropertyAll(20)),
                    onPressed: () {},
                    icon: Icon(CupertinoIcons.heart)),
                Text(
                  '${likes}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Spacer(),
                IconButton(
                    style: ButtonStyle(iconSize: WidgetStatePropertyAll(20)),
                    onPressed: () {},
                    icon: Icon(Icons.comment_outlined)),
                Text(
                  '200',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(
                  width: 15,
                )
              ],
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: secondColor,
                  radius: 15,
                  backgroundImage: NetworkImage(postModel.image ?? nowImage),
                ),
                SizedBox(
                  width: widthR(10, context),
                ),
                SizedBox(
                  height: 40,
                  width: 230,
                  child: TextField(
                    controller: commentController,
                    style: TextStyle(fontSize: 15),
                    cursorHeight: 15,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          // Set border radius
                          borderSide: BorderSide.none, // Removes the border
                        ),
                        labelText: 'write your comment',
                        labelStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.w700),
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                  ),
                ),
                Spacer(),
                IconButton(
                  style: ButtonStyle(iconSize: WidgetStatePropertyAll(20)),
                  onPressed: () {
                    cubit.likePost(postId);
                  },
                  icon: Icon(
                    isLiked ? CupertinoIcons.heart_solid : CupertinoIcons.heart,
                    color: isLiked ? Colors.red : null,
                  ),
                ),
                // heightRe: 30,
                // widthRe: 230,
              ],
            )
          ],
        ),
      ),
    );
  }
}
