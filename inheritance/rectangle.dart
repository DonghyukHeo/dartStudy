import 'shape.dart';

/* 
  추상화 클래스를 상속 받을 경우
  implements 구문으로 상속받으면  추상화 클래스의 모든 멤버를 다 재정의 해야 한다.
*/
class Rectangle implements Shape {
  Rectangle(this.width, this.height);

  double width;
  double height;

  // 추상화 클래스를 상속 받았을 경우에는 반드시 override 해야 한다.
  @override
  double getArea() {
    return width * height;
  }

  @override
  String? color;

  @override
  void draw() {}
}
