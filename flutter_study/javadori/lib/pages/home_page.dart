import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:javadori/components/javadori_colors.dart';
import 'package:javadori/components/javadori_constants.dart';
// import 'package:javadori/main.dart';
import 'package:javadori/pages/add_medicine/add_medicine_page.dart';
import 'package:javadori/pages/history/history_page.dart';
import 'package:javadori/pages/today/today_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; //현재 페이지 인덱스 번호

  // 화면 출력할 list 정의
  // final _pages = [
  //   Container(
  //     color: Colors.grey,
  //   ),
  //   Container(
  //     color: Colors.blue,
  //   ),
  // ];

  /*
    2023.08.31
    각각의 서비스 페이지 개별 구성 및 페이지 호출 네이게이션바 적용
  */

  // 별도 페이지를 만들어서 해당 페이지를 바라보도록 대체
  final _pages = [
    const TodayPage(),
    const HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: pagePadding,
        child: SafeArea(child: _pages[_currentIndex]),
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: () {
        //   // 플로팅버튼 클릭시 새로운 페이지를 띄우고자 할때
        //   Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => AddPage()));
        // },
        onPressed: _onAddMedicine,
        child: const Icon(CupertinoIcons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomAppBar(),
    );
  }

  // BottomAppBar 부분을 별도 함수로 분리
  BottomAppBar _buildBottomAppBar() {
    return BottomAppBar(
      // elevation: 0,  // 그림자 기본값은 1
      child: Container(
        height: kBottomNavigationBarHeight, //bottomNavigationbar의 높이를 지정해둔 정의사용
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CupertinoButton(
                child: Icon(
                  CupertinoIcons.checkmark,
                  // 해당 아이콘이 활성화 되었을 경우 색상 변경 처리
                  color: _currentIndex == 0
                      ? JavadoriColors.primaryColor
                      : Colors.grey[350],
                ),
                onPressed: () {
                  _onCurrentPage(0);
                }),
            CupertinoButton(
              child: Icon(
                CupertinoIcons.text_badge_checkmark,
                // 해당 아이콘이 활성화 되었을 경우 색상 변경 처리
                color: _currentIndex == 1
                    ? JavadoriColors.primaryColor
                    : Colors.grey,
              ),
              // onPressed: () {
              //   setState(() {
              //     _currentIndex = 1;
              //   });
              // },
              onPressed: () => _onCurrentPage(1), //화살표 함수로 표현
            ),
          ],
        ),
      ),
    );
  }

  void _onCurrentPage(int pageIndex) {
    setState(() {
      _currentIndex = pageIndex;
    });
  }

  void _onAddMedicine() {
    // 플로팅버튼 클릭시 새로운 페이지를 띄우고자 할때
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddMedicienPage()),
    );

    // 임시로 가비지 삭제 처리
    // notification.deleteMultipleAlarm(['1919', '800', '1300']);
  }
}
