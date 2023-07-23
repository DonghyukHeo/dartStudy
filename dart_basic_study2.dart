import 'dart:async';

void main() {

  // final 상수 : 값이 변하지 않는 데이터
  // final 상수는 run-time 시 할당이 되다. (실행시)
  final String name = 'Javadori';
  print(name);
  //name = '허대장';  // final 변수로 선언이 되었기 때문에 다른 값으로 변경 할 수 없다.

  // const 상수 : final 처럼 값이 변하지 않는 데이터.
  // const 상수는 complie-time  때 값이 할당이 된다.
  const String name2 = 'Javadori';
  print(name2);


  /*
    final로 선언된 경우 run-time 시 할당이 되기 때문에 아래 코드가 동작이 되지만
    const로 선언이 되면 complie시 할당이 되기 때문에 아래 코드에 사용할 수 없다. 
  */
  final DateTime now = DateTime.now();
  print(now);

  // 1초 후에 동작
  Future.delayed(Duration(seconds: 1), () {
    final DateTime now2 = DateTime.now();
    print('--------');
    print(now);
    print(now2);
  });
}


void basicEmptyNull() {
  // non-nullable : null 값 허용되지 않는다.
  String nonNullableName = '';
  print('nonNullableName = $nonNullableName');
  print('---------------');


  // nullable : null 값이 허용
  // 작성 방법 : 변수타입? (?를 붙여서 선언)
  String? name = '';
  print(name);

  name = 'Javadori';
  print(name);

  name = null;
  print(name);
}