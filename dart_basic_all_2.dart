/* 
  2023.07.28
  Dart 문법 최종 정리 / 함수와 클래스

  함수의 포지셔널 값에 따라서 값 전달이 정확해야 한다.
  변수를 [] 로 묶어 놓으면 해당 값을 생략할 수 있다.
  {} 로 묶으면 네임드 파라미터 처리 반드시 인자를 받게 할 때는 required 키워드를 사용한다.


  class는 인스턴스화 해서 사용한다.
  인스턴스화는 생성자를 통해서 생성이 된다.
  class도 함수와 동일하게 {}로 묶으면 네임드 파라미터 처리로 생성할 수 있다.

  생성자의 파라미터에 this 를 사용하지 않으면 단지 전달에 이용된 파라미터이므로 class 내의 변수값에 영항을 주지 않는다.
*/

void main() {
  int result = add(1, 3);
  print(result);

  int result2 = add(3);
  print(result2);

  int result3 = add2(a: 3, b: 3);
  print(result3);
}

// 옵셔널한 파라이터 처리
int add(int a, [int? b]) {
  return a + (b ?? 0);
}

int add2({required int a, required int b}) {
  return a + b;
}

class Person {
  Person();
}
