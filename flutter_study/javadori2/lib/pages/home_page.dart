import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: SafeArea(
        top: false, // appbar는 적용하지 않게
        child: Scaffold(
            appBar: AppBar(),
            body: Container(
              color: Colors.grey,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(CupertinoIcons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            //bottom 부분
            bottomNavigationBar: BottomAppBar(
              child: Container(
                height: kBottomNavigationBarHeight, //지정된 bottomNavigationBar 높이
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CupertinoButton(
                      child: Icon(
                        CupertinoIcons.checkmark,
                      ),
                      onPressed: () {},
                    ),
                    CupertinoButton(
                      child: Icon(
                        CupertinoIcons.text_badge_checkmark,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
