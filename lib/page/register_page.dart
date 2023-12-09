import 'package:flutter/material.dart';

class registerPage extends StatelessWidget {
   registerPage({super.key});
  String id ='RegisterPage';
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff4c8435),
         automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset('assets/images/chat login.png.png',width: 60,height: 80,),
            const Text('Home'),
          ],
        ),
      ),
      body: const Center(child:  Text('There is no data to display ',style: TextStyle(fontSize: 30,fontFamily: 'Pacifico'),)),
    );
  }
}
