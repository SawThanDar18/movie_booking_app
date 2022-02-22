import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';

class TextFieldView extends StatefulWidget {
  final String hintText;
  final TextInputType textInputType;
  final bool obsecureText;
  final TextStyle textStyle;
  final TextEditingController textEditingController;

  TextFieldView(
      {required this.hintText, required this.textInputType, required this.textStyle, required this.textEditingController, this.obsecureText = false});

  @override
  State<TextFieldView> createState() => _TextFieldViewState();
}

class _TextFieldViewState extends State<TextFieldView> {

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: widget.hintText,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: SPLASH_SCREEN_BACKGROUND_COLOR),
        ),
        hintStyle: widget.textStyle,
        contentPadding: EdgeInsets.symmetric(horizontal: MARGIN_10),
      ),
      keyboardType: widget.textInputType,
      obscureText: widget.obsecureText,
      controller: widget.textEditingController,
    );
  }
}
