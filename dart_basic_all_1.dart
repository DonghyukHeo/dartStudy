/* 
  2023.07.27 
  Dart 문법 정리 / 변수
*/
void main() {
  // var 는 타입추론식 변수
  var variableName = 'value';
  /* 
    타입 추론이 string 식으로 적용이 되었기 때문에 null 값을 허용하지 않는다.
    null 값을 허용하게 할려면 ? 붙여서 선언해야 한다.
  */
  //variableName = null;
  print(variableName);

  //var flybyObject = {'Jupiter', 'Saturn', 'Uranus', 'Neptune'};

  /*
    dynamic 변수는 값에 제한을 하지 않고 여러가지 타입을 받아야 될때 
    즉, 매번 다른 형태의 타입 값을 받아야 할때 사용
   */
  dynamic name;
  name = '홍길동';
  print(name);
  name = 24;
  print(name);
  name = 24.5;
  print(name);
}
