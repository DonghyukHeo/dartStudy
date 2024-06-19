/*
  2023.09.04

  크기 관련 사용자 정의
  
  수치 관련 정보를 코드에 직접 작성시 추후 유지 보수나 수정시 어려움이 있기 때문에
  관련 정보를 변수화로 정의하여 참조하도록 하면 수정시 해당 변수만 수정을 하면
  전체 적용이 되기 때문에 유익하다.
*/

import 'package:flutter/cupertino.dart';

/// 20.0
const double reqularSpace = 20.0;

/// 40.0
const double largeSpace = 40.0;

/// 10.0
const double smallSpace = 10.0;

/// 48.0
const double submitButtonHeight = 48.0;

/// page Padding 20.0
const EdgeInsetsGeometry pagePadding = EdgeInsets.all(20.0);

// TextField Padding
const EdgeInsetsGeometry textFieldContentPadding =
    EdgeInsets.symmetric(horizontal: 6);

/// submitButton 외부 box Padding
const EdgeInsetsGeometry submitButtonBoxPadding = EdgeInsets.symmetric(
  horizontal: 20,
  vertical: 10,
);
