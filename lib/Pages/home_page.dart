import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/Constant/components.dart';
import 'package:social_app/Constant/constans.dart';
import 'package:social_app/Pages/notification_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: secondColor,
                    radius: 30,
                    backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?t=st=1733384278~exp=1733387878~hmac=c1a4d14e798cf17e7e131b5d0125aac3a4928490ee3b44e289471cc469779ef1&w=996'),
                  ),
                  SizedBox(
                    width: widthR(10, context),
                  ),
                  Text(
                    'hi ahmed',
                    style: Theme.of(context).textTheme.bodyMedium,
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
              SizedBox(
                height: heightR(20, context),
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                return buildPost(context);
              }, separatorBuilder: (context, index) {
                return SizedBox(height: heightR(20, context),);
              }, itemCount: 10)
            ],
          ),
        ),
      ),
    ));
  }

  Widget buildPost(context){
    return Container(
      width: widthR(340, context),
      height: heightR(390, context),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black,blurRadius: 20,spreadRadius: -10,offset: Offset(10, 7))],
          color: secondColor, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: secondColor,
                  radius: 35,
                  backgroundImage: NetworkImage(
                      'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?t=st=1733384278~exp=1733387878~hmac=c1a4d14e798cf17e7e131b5d0125aac3a4928490ee3b44e289471cc469779ef1&w=996'),
                ),
                SizedBox(
                  width: widthR(8, context),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ahmed sabaa',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      '10/14/13',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.more_vert))
              ],
            ),
            SizedBox(
              height: heightR(10, context),
            ),
            Container(
              width: widthR(327, context),
              height: heightR(186, context),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)),
              child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://fps.cdnpk.net/images/ai/image-generator/gallery/resource-tti-15.webp')),
            ),
            Row(
              children: [
                IconButton(
                    style: ButtonStyle(
                        iconSize: WidgetStatePropertyAll(20)),
                    onPressed: () {},
                    icon: Icon(CupertinoIcons.heart)),
                Text(
                  '200',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Spacer(),
                IconButton(
                    style: ButtonStyle(
                        iconSize: WidgetStatePropertyAll(20)),
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
                  backgroundImage: NetworkImage(
                      'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?t=st=1733384278~exp=1733387878~hmac=c1a4d14e798cf17e7e131b5d0125aac3a4928490ee3b44e289471cc469779ef1&w=996'),
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
                          borderRadius: BorderRadius.circular(20.0), // Set border radius
                          borderSide: BorderSide.none, // Removes the border
                        ),
                        labelText: 'write your comment',
                        labelStyle: TextStyle(fontSize: 15,color: Colors.grey,fontWeight:FontWeight.w700 ),
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10)
                    ),
                  ),
                ),
                Spacer(),
                IconButton(
                    style: ButtonStyle(
                        iconSize: WidgetStatePropertyAll(20)),
                    onPressed: () {},
                    icon: Icon(CupertinoIcons.heart)),
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
