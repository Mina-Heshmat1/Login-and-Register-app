import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:ui';
import 'package:ui_login_test/page/costom_icon_botton.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ui_login_test/page/register_page.dart';
import 'package:ui_login_test/page/test_form_filed.dart';

import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
      HomePage(),
      title: "Animated-Login-Page-UI",
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
 late AnimationController controller1;
 late AnimationController controller2;
 late Animation<double> animation1;
 late  Animation<double> animation2;
 late  Animation<double> animation3;
 late  Animation<double> animation4;

  @override
  void initState() {
    super.initState();

    controller1 = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 5,
      ),
    );
    animation1 = Tween<double>(begin: .1, end: .15).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller1.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller1.forward();
        }
      });
    animation2 = Tween<double>(begin: .02, end: .04).animate(
      CurvedAnimation(
        parent: controller1,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
      setState(() {});
    });

    controller2 = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 5,
      ),
    );
    animation3 = Tween<double>(begin: .41, end: .38).animate(CurvedAnimation(
      parent: controller2,
      curve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller2.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller2.forward();
        }
      });
    animation4 = Tween<double>(begin: 170, end: 190).animate(
      CurvedAnimation(
        parent: controller2,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
      setState(() {});
    });

    Timer(const Duration(milliseconds: 2500), () {
      controller1.forward();
    });

    controller2.forward();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

 String? email;
 String? password;
 TextEditingController controller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xff192028),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                Positioned(
                  top: size.height * (animation2.value + .58),
                  left: size.width * .21,
                  child: CustomPaint(
                    painter: MyPainter(50),
                  ),
                ),
                Positioned(
                  top: size.height * .98,
                  left: size.width * .1,
                  child: CustomPaint(
                    painter: MyPainter(animation4.value - 30),
                  ),
                ),
                Positioned(
                  top: size.height * .5,
                  left: size.width * (animation2.value + .8),
                  child: CustomPaint(
                    painter: MyPainter(30),
                  ),
                ),
                Positioned(
                  top: size.height * animation3.value,
                  left: size.width * (animation1.value + .1),
                  child: CustomPaint(
                    painter: MyPainter(60),
                  ),
                ),
                Positioned(
                  top: size.height * .1,
                  left: size.width * .8,
                  child: CustomPaint(
                    painter: MyPainter(animation4.value),
                  ),
                ),
                Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(top: size.height * .1),
                        child:Image.asset('assets/images/chat login.png.png',width: 180,height: 100,),
                        // Text(
                        //   'APP NAME',
                        //   style: TextStyle(
                        //     color: Colors.white.withOpacity(.7),
                        //     fontSize: 30,
                        //     fontWeight: FontWeight.bold,
                        //     letterSpacing: 1,
                        //     wordSpacing: 4,
                        //   ),
                        // ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //  TextFormFeild.TextFormFeild(
                          //   isEmail: true,
                          //   isPassword: true,
                          //   hintText: 'Name',
                          //   icon: Icons.person,
                          //    onChanged: (data){
                          //
                          //    },
                          //
                          // ),
                          customeTextField(
                          onChanged: (date) {
                           email = date;
                         },
                              isEmail: true,
                             isPassword: false,
                            hintText: 'Email',
                            icon: Icons.email_outlined,
                          ),
                          customeTextField(
                            onChanged: (date) {
                              password = date;
                            },
                            isEmail: false,
                            isPassword: true,
                            hintText: 'Password',
                            icon: Icons.lock_outline,

                          ),
                          // component1(
                          //     Icons.email_outlined, 'Email...', false, true),
                          // component1(
                          //     Icons.lock_outline, 'Password...', true, false),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              costomIconBotton(
                                text: 'Login',
                                onTap: () async {
                                  try {
                                    await LoginUser().then((value){
                                      if(value.user != null){
                                        showSnackBar(context, 'Login Success');
                                        Navigator.push(context, MaterialPageRoute(builder: (context){
                                          return registerPage();
                                        }));
                                      }
                                    });
                                  }
                                  on FirebaseAuthException catch (e) {
                                    if(e.message != null){
                                      showSnackBar(context, e.message.toString());
                                    }else if (e.code == 'weak-password') {
                                      showSnackBar(context, 'The password provided is too weak.');
                                    } else if (e.code == 'email-already-in-use') {
                                      showSnackBar(context, 'The account already exists for that email.');
                                    }
                                  }

                                },


                          ),
                              SizedBox(width: size.width / 20),
                              costomIconBotton(
                                text: 'ForGot password',


                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          costomIconBotton(
                            text: 'Create a new Account',

                            onTap: () async {
                              try {
                                await registerUser().then((value){
                                  if(value.user != null){
                                    showSnackBar(context, 'done ');
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return registerPage();
                                    }));
                                  }
                                });
                              }
                              on FirebaseAuthException catch (e) {
                                if(e.message != null){
                                  showSnackBar(context, e.message.toString());
                                }else if (e.code == 'weak-password') {
                                  showSnackBar(context, 'The password provided is too weak.');
                                } else if (e.code == 'email-already-in-use') {
                                  showSnackBar(context, 'The account already exists for that email.');
                                }
                              }

                            },
                          ),
                          SizedBox(height: size.height * .05),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }








 Future<UserCredential> registerUser() async {
   UserCredential user = await FirebaseAuth.instance
       .createUserWithEmailAndPassword(
       email: email!, password: password!);
   return user;
 }
 Future<UserCredential> LoginUser() async {
   UserCredential user = await FirebaseAuth.instance
       .signInWithEmailAndPassword(
       email: email!, password: password!);
   return user;
 }
 void showSnackBar(BuildContext context,String massage) {
   ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(
       backgroundColor: Colors.white,
       content: Center(
           child: Text(massage,
               style: TextStyle(
                   color: Colors.red, fontSize: 16))),
     ),);
 }

}





class MyPainter extends CustomPainter {
  final double radius;

  MyPainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
          colors: [Color(0xff4c8435), Color(0xffd3eac8)],//0xffFD5E3D //
          begin: Alignment.topLeft,
          end: Alignment.bottomRight)
          .createShader(Rect.fromCircle(
        center: const Offset(0, 0),
        radius: radius,
      ));

    canvas.drawCircle(Offset.zero, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }


}


// () {
//                                       Navigator.push(context, MaterialPageRoute(builder: (context){return RegisterPage();}));
//                                   HapticFeedback.lightImpact();
//                                   Fluttertoast.showToast(
//                                       msg: 'Login button pressed');
//                                 },








