import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_app/Constant/components.dart';
import 'package:social_app/Constant/constans.dart';
import 'package:social_app/Pages/login_page.dart';
import 'package:social_app/network/local/cache_helper.dart';

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    final path = Path();
    //(0,0) 1
    path.lineTo(0, h);
    path.quadraticBezierTo(w * .1, h - 100, w, h);
    path.lineTo(w, 0);
    path.close();
    return path;
    throw UnimplementedError();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
    throw UnimplementedError();
  }
}

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel(this.image, this.title, this.body);
}

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardingPage> {

  var PageViewController = PageController();
  List<BoardingModel> Boarding = [
    BoardingModel('assets/onBoarding1.png', 'GET NEW FRIENDS',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus aliquet sollicitudin nunc, quis consequat quam faucibus id. Nam rutrum elementum orci eget commodo. Aliquam ut dolor augue. Nulla volutpat erat.'),
    BoardingModel('assets/onBoarding2.png', 'SEND INFINITY MASSAGES  ',
        'Lorem ipsum dolor sit amet, quis consequat quam faucibus id. Nam rutrum elementum orci eget commodo. Aliquam ut dolor augue. Nulla volutpat erat.'),
    BoardingModel('assets/onBoarding3.png', 'COMMUNICATION EASY',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit id. Nam rutrum elementum orci eget commodo. Aliquam ut dolor augue. Nulla volutpat erat.'),
  ];
  bool isLast =false;
  void Submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
      }
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
                child: PageView.builder(
                  controller: PageViewController,
                  onPageChanged: (value) {
                    if(value == Boarding.length -1){
                      setState(() {
                        isLast=true;
                      });
                    }else{
                      setState(() {
                        isLast=false;
                      });
                    }
                  },
                  itemBuilder: (context, index) {
                    return OnBoardingWidget(Boarding[index]);
                  },
                  physics: BouncingScrollPhysics(),
                  itemCount: Boarding.length,
                )),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  SmoothPageIndicator(
                    controller: PageViewController, // PageController
                    count: Boarding.length,
                    effect: WormEffect(
                        type: WormType.thin,
                        dotHeight: heightR(10, context),
                        dotWidth: widthR(10, context),
                        spacing: 5,
                        activeDotColor: defaultColor), // your preferred effect
                  ),
                  Spacer(),
                  FloatingActionButton(
                    backgroundColor: defaultColor,
                    child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                    onPressed: () {
                      if(isLast==true){
                        Submit();
                      }else{
                        PageViewController.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }

                    },
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget OnBoardingWidget(BoardingModel model) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            ClipPath(
              child: Container(
                height: MediaQuery.of(context).size.height * 65 / 100,
                width: double.infinity,
                color: defaultColor,
              ),
              clipper: CustomClipPath(),
            ),
            Image(
              image: AssetImage(model.image),
              width: widthR(350, context),
              height: heightR(350, context),
            ),
            Positioned(
              top:heightR(30, context),
              left: widthR(320, context),
              child: TextButton(
                  onPressed: Submit, child: Text('Skip',style: TextStyle(color: Colors.white),)),
            )
          ],
        ),
        SizedBox(
          height: heightR(10, context),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                model.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: sizeR(30, context),
                ),
              ),
              Text(
                model.body,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: sizeR(10, context),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
      ],
    );
  }
}