import 'package:flutter/material.dart';
import 'package:social_app/Constant/components.dart';
import 'package:social_app/Pages/login_page.dart';
import 'package:social_app/network/local/cache_helper.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(child:ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              CacheHelper.removeData(key: 'uId').then((value) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                      (Route<dynamic> route) => false,
                );
                defaultFlutterToast(massage: 'Sign out done successfully', state: ToastState.SUCCESS);
              },);
            }, child: Text('Sign Out',style: TextStyle(color: Colors.white))),),
      ),);
  }
}
