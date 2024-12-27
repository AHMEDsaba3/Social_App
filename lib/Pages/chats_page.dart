import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Constant/components.dart';
import 'package:social_app/Constant/constans.dart';
import 'package:social_app/shared/AppCubit/appCubit.dart';
import 'package:social_app/shared/AppCubit/appCubit_states.dart';

class ChatsPage extends StatelessWidget {
  ChatsPage({super.key});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        if(cubit.model!=null) {
          return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Chats',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(
                    height: heightR(10, context),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: defaultTextForm(
                        heightRe: 40,
                        context: context,
                        preIcon: Icons.search,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        borderStyle: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        Controller: searchController,
                        label: 'Search',
                        backgroundColor: Colors.grey[300],
                        keyboardType: TextInputType.text),
                  ),
                  SizedBox(
                    height: heightR(10, context),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 70,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: horizontalUsers(context, cubit.users[index].image??''),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: widthR(0, context),
                          );
                        },
                        itemCount: cubit.users.length),
                  ),
                  SizedBox(
                    height: heightR(10, context),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.separated(
                      shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return verticaUsers(context, cubit.users[index].image??'', cubit.users[index].name ?? '');
                        },
                        separatorBuilder: (context, index) => Padding(
                          padding:  EdgeInsets.symmetric(vertical: 10),
                          child: Container(color: Colors.grey[300],height: heightR(1, context),),
                        ),
                        itemCount: cubit.users.length),
                  )
                ],
              ),
            ),
          ),
        );
        } else return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget horizontalUsers(context, String image) {
    return InkWell(
      onTap: () {},
      child: CircleAvatar(
        radius: sizeR(34, context),
        backgroundColor: Colors.black,
        child: CircleAvatar(
          radius: sizeR(33, context),
          backgroundColor: secondColor,
          backgroundImage: NetworkImage(image),
        ),
      ),
    );
  }
  Widget verticaUsers(context, String image,String name) {
    return  InkWell(
      onTap: () {},
      child: Row(
        children: [
          CircleAvatar(
            radius: sizeR(29, context),
            backgroundColor: secondColor,
            backgroundImage: NetworkImage(image),
          ),
          SizedBox(width: widthR(10, context),),
          Text('$name',style: Theme.of(context).textTheme.bodyMedium,)
        ],
      ),
    );
  }
}
