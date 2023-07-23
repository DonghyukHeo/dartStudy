import 'student.dart';

void main() {
  print('class 공부');
  //print(name);  //정의된 변수가 아니라서 에러 발생
  // instance 인스턴스 : object(객체) 생성
  //Student boyStudent = Student();
  Student boyStudent = Student('아옹이', 10);
  print(boyStudent.name); // instance로 class의 변수로 접근
  print(boyStudent.age);

  boyStudent.name = '허대장';
  boyStudent.age = 24;
  print(boyStudent.name); 
  print(boyStudent.age);
  boyStudent.printInfo();

  Student2 girlStudent = Student2(name: '나연', age : 22);
  girlStudent.printInfo();

  // setter 호출  
  Student3 student3 = Student3(name : '기안', age : 40);
  student3.name = '기안84';  // setter 호출
  //student3._name = "홍길동";  // private 변수는 직접적인 호출을 할 수 없다.
  print('main = ${student3.name}');
  student3.printInfo();
}

/*
  Class : 객체지향프로그래밍(OOP)에서 특정 object(객체) 생성하기 위해 정의하는 일종의 틀
  - class는 변수와 함수를 정의할 수 있습니다.
  - 비슷한 성격을 가진 연관있는 변수와 함수들을 한 class에 정의한다.

  선언 (클래스명은 앞글자를 대문자로 작성하자.)
  class 클래스명 {}
 */

class Student {

  // 생성자 constructor
  //Student();  
  Student(this.name, this.age);

  String name = 'Javadori';
  int? age;


  void printInfo() {
    print('-------');
    print('name : $name');
    print('age ; $age');
    print('-------');
  }
}

class Student2 {

  // 생성자 constructor
  //Student();  
  Student2({ required this.name, this.age});

  String name = 'Javadori';
  int? age;

  void printInfo() {
    print('-------');
    print('name : $name');
    print('age ; $age');
    print('-------');
  }
}