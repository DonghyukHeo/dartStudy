class Javadori extends Person {
  Javadori({required super.name});

}

class Hero extends Person {

  // super는 부모를 가르킨다. super.name 은 Persion class의 name을 말하는 것이다.
  // 상속을 받게 되면 부모의 함수를 이용할 수 있다.
  Hero({required super.name});

  void fly() {
    print('$name, 날다.');
  }

  // 부모 클래스의 함수가 자식 클래스에서 재정의 된다.
  //@override
  void walk() {
    print('---- walk -----');
    // super 키워드를 사용해서 부모의 함수를 호출할 수 있다.
    super.walk();
    print('$name, 뛴다.');
    print('---- walk -----');
  }
  

 

}

class Person {

  Person({ required this.name });

  String name;

  void speak() {
    print('안녕 나는 $name입니다.');
  }

  void walk() {
    print('$name은 걷는다');
  }
}