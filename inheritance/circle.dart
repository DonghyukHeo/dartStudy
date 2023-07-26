import 'shape.dart';

class Circle extends Shape {
  Circle(this.redius);

  double redius;

  // 추상화 클래스를 상속 받았을 경우에는 반드시 override 해야 한다.
  @override
  double getArea() {
    return redius * redius * 3.14;
  }

  @override
  void draw() {
    // TODO: implement draw
  }
}
