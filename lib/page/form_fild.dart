import 'package:flutter/material.dart';

class customeTextField extends StatelessWidget {
  final String label;
  final IconData Icons ;
  final String hintText;
  final Function(String)?onChanged;

  const customeTextField({super.key, required this.label, required this.Icons, this.onChanged, required this.hintText});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 60,
      width: 350 ,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.05),
        borderRadius: BorderRadius.circular(15),
      ),

      child: TextField(
        style: TextStyle(color: Colors.yellowAccent),
        onChanged: onChanged,
        decoration: InputDecoration(

          labelText: label ,
          hintText: hintText,
          labelStyle: TextStyle(color: Colors.white54),
          prefixIcon:  Icon(Icons),
          prefixIconColor: Colors.white,
        ),
      ),
    );
  }
}
