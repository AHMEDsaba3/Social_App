import 'package:flutter/material.dart';
import 'package:social_app/Constant/components.dart';
import 'package:social_app/Constant/constans.dart';
import 'package:social_app/models/user_model.dart';

class ChatDetailsPage extends StatelessWidget {
  ChatDetailsPage({super.key, required this.user});

  UserModel user;
  TextEditingController massageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: heightR(50, context),
            decoration: BoxDecoration(
                color: defaultColor,
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)]),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios)),
                Hero(
                  tag: user.id??'',
                  child: CircleAvatar(
                    radius: sizeR(20, context),
                    backgroundColor: secondColor,
                    backgroundImage: NetworkImage(user.image ?? ''),
                  ),
                ),
                SizedBox(
                  width: widthR(30, context),
                ),
                Text(
                  user.name ?? '',
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: heightR(60, context),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(10),
                          topEnd: Radius.circular(10),
                          bottomEnd: Radius.circular(10),
                        )),
                    child: Text('seder massage',style: Theme.of(context).textTheme.titleSmall),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.blue[300],
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(10),
                          topEnd: Radius.circular(10),
                          bottomStart: Radius.circular(10),
                        )),
                    child: Text('my massage',style: Theme.of(context).textTheme.titleSmall,),
                  ),
                ),
                SizedBox(height: heightR(10, context),),
                Row(
                  children: [
                    defaultTextForm(
                        context: context,
                        widthRe: 310,
                        Controller: massageController,
                        label: 'enter your massage',
                        keyboardType: TextInputType.text),
                    IconButton(onPressed: null, icon: Icon(Icons.send))
                  ],
                ),
                SizedBox(height: heightR(10, context),),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
