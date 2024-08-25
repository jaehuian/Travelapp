import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/Account_controller.dart';
import '../../routes/router.dart';

//최상단 앱바
class MainAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  const MainAppBar({super.key, required this.title}); //앱바 타이틀 받아옴

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

//바텀 네비게이션
class MainBottomView extends StatefulWidget{
  const MainBottomView({super.key});

  @override
  State<MainBottomView> createState() => _MainBottomViewState();
}


//바텀 네비게이션 UI
class _MainBottomViewState extends State<MainBottomView>{
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MainRouter.widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false, //버튼 라벨 숨기기
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
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

//플로팅 버튼
class FloatButton extends StatefulWidget{
  final String label;
  final int index;
  final AccountController controller; //가계부 컨트롤러

  //플로팅버튼 라벨, 인덱스, 컨트롤러(가계부) 받아옴
  FloatButton({super.key, required this.label, required this.index, required this.controller});

  @override
  _FloatButtonState createState() => _FloatButtonState();
}
class _FloatButtonState extends State<FloatButton>{

  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: 70,
      width: 50,
      child:
      FloatingActionButton.extended(
        onPressed: () {
          widget.controller.setBodyIndex(widget.index); //바디인덱스 전달
          debugPrint('Accountbody Index: ${widget.controller.bodyIndex}'); //로그 출력
          },
        label: Text(widget.label),
        backgroundColor: Colors.blue,
      ),);
  }
}