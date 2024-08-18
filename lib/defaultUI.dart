import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//최상단 앱바
class MainAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  const MainAppBar({super.key, required this.title}); //생성자

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        IconButton(
          icon: const Text('환경설정'),
          onPressed: (){},
        )
      ],
    );
  }

  @override
  // 앱바 사이즈 지정 - 기본 앱바 크기 (56.0 dp)
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

//가계부 바디
class AccountBody extends StatefulWidget{
  const AccountBody({super.key});

  @override
  _AccountBodyState createState() => _AccountBodyState();
}

//가계부 바디 UI
class _AccountBodyState extends State<AccountBody>{

  @override
  Widget build(BuildContext context){
    return const Center(
      child: Text('바디 영역 입니다'),
    );
  }
}

//바텀 네비게이션
class MainBottom extends StatefulWidget{
  const MainBottom({super.key});

  @override
  _MainBottomState createState() => _MainBottomState();
}

//바텀 네비게이션 UI
class _MainBottomState extends State<MainBottom>{
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Text('가계부'),
            label: '가계부',
          ),
          BottomNavigationBarItem(
            icon: Text('여행'),
            label: '여행',
          ),
        ]
    );
  }
}