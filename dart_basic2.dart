import 'inheritance/circle.dart';
import 'inheritance/rectangle.dart';
import 'inheritance/shape.dart';

/* 
  2023.07.26
  추상화

  클래스를 선언할 때 abstract 로 추상화 클래스로 적용
  추상화 클래스를 상속 받았을 경우에는 추상화 클래스의 함수를 반드시 
  자식 클래스에서 override 해줘야 한다. (강제성 부여)

  추상화 클래스를 상속 받을 경우 implements 키워드로 상속받으면
  추상화 클래스의 모든 멤버를 재정의해야 하며
  extends 키워드로 상속 받으면 body 부분이 없는 (메소드 구현체가 없는 것) 것만 
  재정의 하면 된다.
*/
void main() {
  Circle circle = Circle(3);
  Rectangle rectangle = Rectangle(5, 10.3);

  // Shape 클래스를 상속 받기 때문에 자식 클래스로 전달해서 호출 할 수 있다.
  printArea(circle);
  printArea(rectangle);

  // 추상화 클래스는 인스턴스화 할 수 없다.
  // Shape s = Shape();
  // printArea(Shape());
}

void printArea(Shape shape) {
  print('면접 : ${shape.getArea()}');
}
