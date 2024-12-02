import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

double heightR(double x, BuildContext context) {
  var h = MediaQuery.of(context).size.height;
  return x / 844 * h;
}

double widthR(double x, BuildContext context) {
  var w = MediaQuery.of(context).size.width;
  return x / 390 * w;
}

double sizeR(double x, BuildContext context) {
  var h = MediaQuery.of(context).size.height;
  var w = MediaQuery.of(context).size.width;
  return x / 326160 * w * h;
}

Widget defaultTextForm(
    {required BuildContext context,
    required TextEditingController Controller,
    required String label,
    required TextInputType keyboardType,
    IconData? preIcon,
    IconData? sufIcon,
    bool ispassword = false,
    String? Function(String?)? validator,
    void Function(String)? onChangedFun,
    void Function(String)? onFieldSubmitted,
    Function()? suffixPressed,
    int? maxLine,
    double? radius,
    double? widthRe,
    double? heightRe,
    bool readonly = false,
    FocusNode? focusNode,
    int? minLine}) {
  return SizedBox(
    width: widthRe != null ? widthR(widthRe, context) : null,
    height: heightRe != null ? widthR(heightRe, context) : null,
    child: TextFormField(
      maxLines: maxLine ?? 1,
      minLines: minLine,
      keyboardType: keyboardType,
      onChanged: onChangedFun,
      validator: validator,
      autovalidateMode:
          validator != null ? AutovalidateMode.onUserInteraction : null,
      controller: Controller,
      obscureText: ispassword,
      style: TextStyle(color: Colors.black,fontSize: sizeR(17, context)),
      decoration: InputDecoration(
        label: Text(
          label,
          style: TextStyle(
              fontSize: sizeR(15, context),
              color: Color(0xff80000000),
              fontWeight: FontWeight.bold),
        ),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 17))),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: preIcon != null ? Icon(preIcon) : null,
        ),
        prefixIconConstraints: BoxConstraints.tightFor(),
        suffixIcon: sufIcon != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(sufIcon))
            : null,
      ),
      readOnly: readonly == true ? true : false,
      focusNode: focusNode,
      enableInteractiveSelection: readonly == true ? false : true,
      onFieldSubmitted: onFieldSubmitted,
    ),
  );
}

void defaultFlutterToast({required String massage,required ToastState state}){
   Fluttertoast.showToast(
      msg: massage,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor:chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

enum ToastState {SUCCESS,ERROR,WARNING}
Color chooseToastColor(ToastState state){
  Color color;
  switch(state){
    case ToastState.SUCCESS:
      color= Colors.green;
    break;
    case ToastState.ERROR:
      color= Colors.red;
      break;
    case ToastState.WARNING:
      color= Colors.amber;
      break;
  }
  return color;
}

