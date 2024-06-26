import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final GestureTapCallback onPressed; //아이콘이 눌렀을 때 실행할 함수
  final IconData iconData;

  const CustomIconButton(
      {super.key, required this.onPressed, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      iconSize: 30.0,
      color: Colors.white,
      icon: Icon(iconData),
    );
  }
}
