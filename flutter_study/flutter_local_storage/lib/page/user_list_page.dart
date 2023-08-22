import 'package:flutter/material.dart';
import 'package:flutter_local_storage/model/inputform.dart';

/*
  데이터를 저장하기 위한 입력 폼 만들기
  : 이름, 나이 

  ListView는 스크롤이 가능한 영역으로 처리해지 않으면 hasSize 에러가 발생

  DB저장소
  1. 클라우드 저장소 : 외부 서비스에 영구적으로 저장하는 공간으로 인터넷이 연결된 상태에서 사용가능하며,
  서버 사용 비용 및 보안관련 조치가 필요하다.
  2. 로컬저장소 : 기기의 내부에 저장하는 방식으로 인터넷 연결이 필요가 없으며, mssql lite와 hive 방식이 있다.
*/

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  final users = <InputForm>[];

  //화면이 꺼질때 controller를 dispose 처리
  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로컬 저장소'),
      ),
      body: Column(
        children: [
          Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  label: const Text('name'),
                ),
              ),
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number, //숫자만 입력이 되도록
                decoration: InputDecoration(
                  label: const Text('age'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // 화면을 재호출 처리
                  setState(() {
                    //string 값을 int 값으로 캐스팅 처리(parse)
                    users.add(
                      InputForm(
                        name: nameController.text,
                        age: int.parse(ageController.text),
                      ),
                    );
                    nameController.clear();
                    ageController.clear();
                  });
                },
                child: const Text('추가'),
              )
            ],
          ),
          const Divider(), //화면을 분할 표시
          //listview는 스크롤이 가능한 영역으로 처리해지 않으면 hasSize 에러가 발생
          Expanded(
            child: users.isEmpty
                ? const Text(
                    '데이터가 없습니다.') // 아직 해당 List에 값이 없을때 호출이 될 수 있어서 에러가 발생하기 때문에 예외처리가 필요
                : ListView.builder(
                    itemCount: users.length, // users의 길이 만큼 item을 생성
                    itemBuilder: (context, i) {
                      return ListTile(
                        // 아직 해당 List에 값이 없을때 호출이 될 수 있어서 에러가 발생하기 때문에 예외처리가 필요
                        title: Text(users[i].name),
                        subtitle: Text(users[i].age.toString()),
                      );
                    }),
            // : ListView(
            //     children: [
            //       ListTile(
            //         // 아직 해당 List에 값이 없을때 호출이 될 수 있어서 에러가 발생하기 때문에 예외처리가 필요
            //         title: Text(users[0].name),
            //         subtitle: Text(users[0].age.toString()),
            //       )
            //     ],
            //   ),
          ),
        ],
      ),
    );
  }
}
