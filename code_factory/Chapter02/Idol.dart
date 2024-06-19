class Idol {
  final String name;

  // Idol(String name) : this.name = name;
  Idol(this.name);

  void sayName() {
    print('저는 ${this.name}입니다.');
  }
}

class Idol2 {
  final String name;
  final int memberCount;

  String _className = '허대장';

  Idol2(this.name, this.memberCount);

  Idol2.fromMap(Map<String, dynamic> map)
      : this.name = map['name'],
        this.memberCount = map['memberCount'];

  //게터, 세터
  String get className {
    return this._className;
  }

  set Idol2Name(String name) {
    this._className = name;
  }

  void sayName() {
    print('저는 ${name}입니다. ${name} 멤버는 ${memberCount}명 입니다.');
  }

  void sayClassName() {
    print('프라이빗 이름은 ${_className} 입니다.');
  }
}

//상속
class BoyGroup extends Idol2 {
  BoyGroup(String name, int memberCount) : super(name, memberCount);

  @override
  void sayName() {
    print('저는 남자 아이돌 ${name}입니다.');
  }

  void sayMale() {
    print('${name}는 남자 아이돌입니다.');
  }
}

//인터페이스
class GirlGroup implements Idol {
  final String name;

  GirlGroup(this.name);

  void sayName() {
    print('저는 여자 아이돌 ${name}입니다.');
  }
}

//믹스인
mixin IdolSingMixin on Idol {
  void sing() {
    print('${name}은 노래를 부릅니다.');
  }
}

//믹스인을 적용할 때는 with 키워드 사용
class BoyGroup2 extends Idol with IdolSingMixin {
  BoyGroup2(super.name);

  void sayMale() {
    print('${name}은 남자 아이돌 입니다.');
  }
}

//추상클래스
abstract class IdolAbstract {
  final String name;
  final int memberCount;

  IdolAbstract(this.name, this.memberCount);

  void sayName();
  void sayMemberCount();
}

//추상클래스 구현
class GirlGroups implements IdolAbstract {
  final String name;
  final int memberCount;

  GirlGroups(this.name, this.memberCount);

  void sayName() {
    print('저는 여자 아이돌 ${name}입니다.');
  }

  void sayMemberCount() {
    print('${name} 멤버는 ${memberCount}명 입니다.');
  }
}

//제네릭
class Cache<T> {
  final T data;

  Cache({
    required this.data,
  });
}

//스태틱
class Counter {
  static int i = 0;

  Counter() {
    print(++i);
  }
}

void main() {
  Idol blackPink = Idol('블랙핑크');

  blackPink.sayName();

  Idol bts = Idol('BTS');
  bts.sayName();

  print('-----');

  Idol2 blackPink2 = Idol2('블랙핑크', 4);
  blackPink2.sayName();

  Idol2 bts2 = Idol2.fromMap({'name': 'BTS', 'memberCount': 7});
  bts2.sayName();

  bts2.sayClassName();
  bts2.Idol2Name = '아이유';
  bts2.sayClassName();

  print('-----');

  BoyGroup bts3 = BoyGroup('BTS', 7);
  bts3.sayName();
  bts3.sayClassName();
  bts3.sayMale();

  print('-----');

  GirlGroup girgroup = GirlGroup('아이브');
  girgroup.sayName();

  print('-----');

  BoyGroup2 boygroup2 = BoyGroup2('세븐틴');
  boygroup2.sing();

  print('-----');

  GirlGroups girlgroups = GirlGroups('아이브', 5);
  girlgroups.sayName();
  girlgroups.sayMemberCount();

  print('-----');

  final cache = Cache<List<int>>(data: [1, 2, 3]);

  print(cache.data.reduce((value, element) => value + element));

  print('-----');

  Counter count1 = Counter();
  Counter count2 = Counter();
  Counter count3 = Counter();

  print('-----');

  BoyGroup bg = BoyGroup('BTS', 5)
    ..sayName()
    ..sayMale()
    ..sayClassName();
}
