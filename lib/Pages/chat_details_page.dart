import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Constant/components.dart';
import 'package:social_app/Constant/constans.dart';
import 'package:social_app/models/massage_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/AppCubit/appCubit.dart';
import 'package:social_app/shared/AppCubit/appCubit_states.dart';

class ChatDetailsPage extends StatefulWidget {
  ChatDetailsPage({super.key, required this.user});

  UserModel user;


  @override
  State<ChatDetailsPage> createState() => _ChatDetailsPageState();
}

class _ChatDetailsPageState extends State<ChatDetailsPage> {
  bool isMessagesLoaded = false; // Flag to check if messages are loaded

  TextEditingController massageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (!isMessagesLoaded) {
          AppCubit.get(context).getMessage(receiverId: widget.user.id ?? '');
          isMessagesLoaded = true;
        }
        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            AppCubit cubit = AppCubit.get(context);
            return Scaffold(
                body: SafeArea(
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: heightR(50, context),
                        decoration: BoxDecoration(
                            color: cubit.isDark?defaultDarkColor:defaultColor,
                            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)]),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.arrow_back_ios)),
                            Hero(
                              tag: widget.user.id??'',
                              child: CircleAvatar(
                                radius: sizeR(20, context),
                                backgroundColor: secondColor,
                                backgroundImage: NetworkImage(widget.user.image ?? ''),
                              ),
                            ),
                            SizedBox(
                              width: widthR(30, context),
                            ),
                            Text(
                              widget.user.name ?? '',
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
                            if(cubit.messages.isNotEmpty)
                            Expanded(
                              child: ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder:(context, index) {
                                var message=cubit.messages[index];
                                if(cubit.model?.id==message.senderId)
                                  return  myMessage(context,message);
                                return receiverMessage(context,message);
                              }, separatorBuilder:(context, index) {
                                return SizedBox(height: heightR(10, context),);
                              } , itemCount: cubit.messages.length),
                            )
                            else Center(child: Text('send some messages',style: Theme.of(context).textTheme.bodyLarge,)),
                            Row(
                              children: [
                                defaultTextForm(
                                    context: context,
                                    widthRe: 310,
                                    Controller: massageController,
                                    label: 'enter your massage',
                                    keyboardType: TextInputType.text),
                                IconButton(onPressed:
                                    () {
                                  if(massageController.text!='')
                                  cubit.sendMessage(receiverID: widget.user.id??'', dateTime: DateTime.now().toString(), text: massageController.text);
                                  massageController.clear();
                                  }

                                    , icon: Icon(Icons.send))
                              ],
                            ),
                            SizedBox(height: heightR(10, context),),
                          ],
                        ),
                      )
                    ],
                  ),
                )) ;
          },
        );
      },
    );
  }

  Widget myMessage(context,MessageModel message){
    return Align(
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
        child: Text('${message.text}',style: Theme.of(context).textTheme.bodySmall,),
      ),
    );
  }

  Widget receiverMessage(context,MessageModel message){
    return Align(
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
        child: Text('${message.text}',style: Theme.of(context).textTheme.bodySmall),
      ),
    );
  }
}
