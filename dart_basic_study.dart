void main() {
  basicList();
  print('--------');
}

// list 타입
void basicList() {
  //list
  List list = [];
  print(list);
  print(list.length);

  // list안에 값을 추가
  list.add('a');
  list.add('b');
  print(list);
  print(list.length);

  list.add(13);
  print(list);
  print(list.length);

  // list 안의 값을 string으로 제한할때 제너릭 타입
  List<String> stringList = <String>[];

  stringList.add('a');
  stringList.add('b');
  print(stringList);
  print(stringList.length);

  //stringList.add(13); //string 타입의 제너릭이기 때문에 int 값을 넣을 수 없다.

  // 2번째 들어 있는 값 출력(index로 접근할 때는 0부터 시작함)
  print(stringList[1]);

  // 값을 한번에 추가
  stringList.addAll(['a', 'b', 'c']);
  print(stringList);

  //값이 포함이 되어져 있는지 체크 (b 라는 값이 있는지 체크)
  print(stringList.contains('b'));

  print(stringList.last);
  print(stringList.first);

  //index 기반 값 수정
  stringList[0] = '가';
  print(stringList);

  //값 삭제
  stringList.remove('가');
  print(stringList);

  stringList.add('a');
  print(stringList);
  //index 기반 삭제
  stringList.removeAt(0);
  print(stringList);
}

// set 타입
void basicSet() {
  // set string 타입의 제너릭
  Set<String> set = {};

  set.add('a');
  set.add('b');
  set.add('c');
  print(set);
  print(set.length);
  // set은 순서보장 안되는 열거 타입이기 때문에 index로 접근할 수 없다.
  //print(set[1]);

  // set 은 열거 타입이기 때문에 중복을 허용하지 않는다. 즉, 동일 값은 한번만 들어갈 수 있다.
  set.add('a');
  print(set);

  // list 타입보다 처리 속도가 빠르다.

  // 값이 포함되어져 있는지 확인
  print(set.contains('b'));
}
