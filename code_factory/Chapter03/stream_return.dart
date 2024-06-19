// Stream을 반환하는 함수는 async* 로 선언
Stream<String> calculate(int number) async* {
  for (int i = 0; i < 5; i++) {
    //yield 키워드를 이용하여 값 반환
    yield 'i = $i';
    await Future.delayed(Duration(seconds: 1));
  }
}

void playStream() {
  calculate(1).listen((event) {
    print(event);
  });
}

void main() {
  playStream();
}
