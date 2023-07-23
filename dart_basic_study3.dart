import 'dart:math';

void main() {
  int weight = 65;
  int count = 0;

  // while 반복문 
  while(weight > 50) {
    print('총 몸무게 : $weight');
    count++;
    print('줄넘기 횟수 : $count');

    var removeWeight = Random().nextInt(2); //랜덤으로 최대값 이하의 값을 생성 
    weight = weight - removeWeight;
    print('감량 무게 : $removeWeight');
    print('총 몸무게 : $weight');

  }
}