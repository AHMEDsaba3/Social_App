import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Constant/components.dart';
import 'package:social_app/Constant/constans.dart';
import 'package:social_app/Layout/main_page.dart';
import 'package:social_app/Pages/home_page.dart';
import 'package:social_app/shared/AppCubit/appCubit.dart';
import 'package:social_app/shared/AppCubit/appCubit_states.dart';

class AddPostPage extends StatelessWidget {
  AddPostPage({super.key, required this.image, required this.name});

  String image;
  String name;
  TextEditingController postController = TextEditingController();
  TextEditingController imageLinkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {
        if(state is CreatePostsSuccessState){
          AppCubit.get(context).getAllPosts();
          Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),));
        }
      },
      builder: (context, state) {
        AppCubit cubit=AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[300],
            centerTitle: true,
            title: Text(
              'Create post',
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium,
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    cubit.createPost(text: postController.text, image: imageLinkController.text, dateTime: DateTime.now().toString());
                  },
                  child: Text('Post', style: TextStyle(color: defaultColor))),
              SizedBox(
                width: widthR(10, context),
              )
            ],
          ),
          body: SafeArea(
            child:
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(state is CreatePostsLoadingState)
                      LinearProgressIndicator(color: secondColor,),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: secondColor,
                          radius: 20,
                          backgroundImage: NetworkImage(image),
                        ),
                        SizedBox(
                          width: widthR(10, context),
                        ),
                        Text(
                          '$name',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium,
                        ),
                        Spacer(),
                        IconButton(onPressed: () {
                          showDialog(context: context, builder: (context) {
                            return AlertDialog(
                              title: Text('Add Image Link',style: Theme.of(context).textTheme.bodyMedium,),
                              content: defaultTextForm(
                                context: context,
                                Controller: imageLinkController,
                                label: 'add image link..',
                                keyboardType: TextInputType.text,
                                maxLine: null,
                                borderStyle: OutlineInputBorder(
                                    borderSide: BorderSide.none
                                ),
                              ),
                              actions: [  TextButton(onPressed: Navigator.of(context).pop, child: Text('Ok'))],
                            );
                          },);
                        }, icon: Icon(Icons.image, color: Colors.green,))
                      ],
                    ),
                    SizedBox(
                      height: heightR(10, context),
                    ),
                    defaultTextForm(
                      context: context,
                      Controller: postController,
                      label: 'What is on your mind?..',
                      keyboardType: TextInputType.text,
                      maxLine: null,
                      borderStyle: OutlineInputBorder(
                          borderSide: BorderSide.none
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
