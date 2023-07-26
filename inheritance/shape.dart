// abstract 클래스
abstract class Shape {
  String? color;

  void draw();

  // override 할 함수이기 때문에 바디 부분을 삭제하고 class를 추상화 처리 한다.
  double getArea() => 0;
}
