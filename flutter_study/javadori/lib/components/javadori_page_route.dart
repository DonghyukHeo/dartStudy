import 'package:flutter/material.dart';

/*
  2023.09.07

  MaterialPageRoute 로 페이지 전환을 대체하여 
  fade 효과를 보여주며 페이지가 전환이 되도록 하기 위한 class
  MaterialPageRoute 대신 FadePageRoute 를 동일하게 적용 
*/

class FadePageRoute extends PageRouteBuilder {
  final Widget page;

  FadePageRoute({required this.page})
      : super(
          pageBuilder: (
            context,
            animation,
            secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
