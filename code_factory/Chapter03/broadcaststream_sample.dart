import 'dart:async';

void main() {
  final controller = StreamController();
  final stream = controller.stream.asBroadcastStream();

  final streamListner1 = stream.listen((event) {
    print('listnening 1');
    print(event);
  });

  final streamListner2 = stream.listen((event) {
    print('listnening 2');
    print(event);
  });

  //Stream 값을 주입하기
  controller.sink.add(1);
  controller.sink.add(2);
  controller.sink.add(3);
  controller.sink.add(4);
}
