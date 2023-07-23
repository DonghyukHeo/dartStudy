class Student3 {

  // 생성자 constructor
  //Student();  
  Student3({ required String name, this.age}) : _name = '$name 학생';

  // private 변수 _ 시작
  String _name;
  // public 변수
  int? age;

  // setter
  set name(String value) {
    _name = '$value 학생';
  }

  // getter
  // 반환되는 변수의 자료형이 정해지므로 자료혈을 정해줘야 한다.
  // String get name{ 
  //   print('getter $_name');
  //   return _name;
  // }

  // getter 를 위의 기본 방식이 아닌 람다식으로 표현
  String get name => _name;

  void printInfo() {
    print('-------');
    print('name : $_name');
    print('age ; $age');
    print('-------');
  }
}