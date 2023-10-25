import 'package:flutter/material.dart';
import 'package:javadori/components/javadori_constants.dart';

class AddPageBody extends StatelessWidget {
  const AddPageBody({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context)
            .unfocus(); //입력창에서 키보드를 불러온 이후 다른 곳에 터치시 키보드를 닫게 처리
      },
      // 키보드 호출시 화면이 overflow 되지 않게 스크롤이 가능하도록 SingleChildScrollView로 감싼다.
      child: Padding(
        padding: pagePadding, //const EdgeInsets.all(20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: children),
      ),
    );
  }
}

class BottomSubmitButton extends StatelessWidget {
  const BottomSubmitButton(
      {super.key, required this.onPressed, required this.text});

  final VoidCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: submitButtonBoxPadding, //javadori_constants 에 지정한 수치
        child: SizedBox(
          height: submitButtonHeight, //javadori_constants 에 지정한 수치
          child: ElevatedButton(
            //onPressed: () {},
            // onPressed: _nameController.text.isEmpty
            //     ? null // null 값으로 하면 해당 버튼이 disabled가 된다.
            //     : _onAlarmPage,
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              textStyle: Theme.of(context).textTheme.subtitle1,
            ),
            // child: const Text('다음'),
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
