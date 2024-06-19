void main() {
  //addNumbers(1, 2);

  print('-----');

  addNumbers2(1, 2);
  addNumbers2(2, 2);
}

void addNumbers(int number1, int number2) {
  print('$number1 + $number2 계산 시작!');

  Future.delayed(Duration(seconds: 3), () {
    print('$number1 + $number2 = ${number1 + number2}');
  });

  print('$number1 + $number2 실행 끝!');
}

Future<void> addNumbers2(int number1, int number2) async {
  print('$number1 + $number2 계산 시작!');

  await Future.delayed(Duration(seconds: 3), () {
    print('$number1 + $number2 = ${number1 + number2}');
  });

  print('$number1 + $number2 실행 끝!');
}
