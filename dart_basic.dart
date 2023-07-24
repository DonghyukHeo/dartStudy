

import 'inheritance/person.dart';

/*
  class의 상속
 */
void main() {
  print('inheritance Study');

  Person mom = Person(name : '엄마');
  mom.speak();
  mom.walk();
  //mom.fly();  // 부모는 자식에 정의된 함수를 알수 없기 때문에 호출할 수 없다.
  print(mom.name);


  Hero child = Hero(name: '자식');
  print(child.name);
  //상속 받은 자식은 부모의 함수를 사용할 있다.
  child.speak();
  child.walk();
  child.fly();  // 자식은 본인의 고유한 함수를 사용할 수 있다.

  print('----------------');

  // 자식 class로 부모 class를 선언할 수 있다.
  Person child2 = Hero(name: '자식2');
  //child2.fly(); // Person 클래스이기 때문에 fly() 함수가 없다.
  child2.speak();
  // 자식 클래스를 받아서 생성이 되었기 때문에 자식 클래스에서 재정의한 walk 함수가 호출이 된다.
  child2.walk();

  speakName(mom);
  speakName(child);
  speakName(child2);
  
}

  void speakName(Person person) {
    print('이름 : ${person.name}');
  }