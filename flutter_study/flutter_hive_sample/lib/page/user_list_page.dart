import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/inputform.dart';

/*
  2023.08.25

  Hive 객체 adapters 이용 데이터 저장하기

  객체를 생성을 위한 별도의 명령을 통해서 adapters를 만들어주어야 하며,
  key 에 접근하기 위해서는 extends HiveObject 상속받아야 한다.
*/
class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  late Box _darkMode; // late 키워드를 통해서 추후 반드시 값이 있다는 것을 명시
  late Box<InputForm> _inputFormBox;

  // 처음 실행시 Hive의 box 지정
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _darkMode = Hive.box('darkModeBox');
    _inputFormBox = Hive.box<InputForm>('InputFormBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive 저장소'),
      ),
      body: Column(
        children: [
          Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  label: Text('name'),
                ),
              ),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number, //숫자만 입력이 되도록
                decoration: const InputDecoration(
                  label: Text('age'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // box에 add 하기
                  _inputFormBox.add(
                    InputForm(
                      name: nameController.text,
                      age: int.parse(ageController.text),
                    ),
                  );
                  nameController.clear();
                  ageController.clear();
                },
                child: const Text('추가'),
              )
            ],
          ),
          const Divider(), //화면을 분할 표시
          //listview는 스크롤이 가능한 영역으로 처리해지 않으면 hasSize 에러가 발생
          ValueListenableBuilder(
              valueListenable: Hive.box<InputForm>('inputFormBox').listenable(),
              builder: (context, Box<InputForm> inputFormBox, widget) {
                final users = inputFormBox.values.toList();
                return Expanded(
                  child: users.isEmpty
                      ? const Text(
                          '데이터가 없습니다.') // 아직 해당 List에 값이 없을때 호출이 될 수 있어서 에러가 발생하기 때문에 예외처리가 필요
                      : ListView.builder(
                          itemCount: users.length, // users의 길이 만큼 item을 생성
                          itemBuilder: (context, i) {
                            final inputForm = users[
                                i]; // key 값 가져오기 삭제 명령 : inputFormBox.delete(inputForm.key);

                            return ListTile(
                              // 아직 해당 List에 값이 없을때 호출이 될 수 있어서 에러가 발생하기 때문에 예외처리가 필요
                              title: Text(users[i].name),
                              subtitle: Text(users[i].age.toString()),
                            );
                          },
                        ),
                );
              }),
        ],
      ),
    );
  }
}
