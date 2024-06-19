import 'dart:async';

void main() {
  final controller = StreamController();
  final stream = controller.stream;

  final streamListner1 = stream.listen((event) {
    print(event);
  });

  //Stream 값을 주입하기
  controller.sink.add(1);
  controller.sink.add(2);
  controller.sink.add(3);
  controller.sink.add(4);
}
