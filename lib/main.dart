import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Account&Travel', //앱 이름
      home: TravelAppHome(title: '가계부'),
    );
  }
}

//임시로 Stateless 지정 나중에 Stateful로 변경
class TravelAppHome extends StatelessWidget{
  final String title;
  TravelAppHome({required this.title}); //생성자 - 매개변수를 멤버변수에 바로 저장

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: MainAppBar(title: title), //'가계부' 타이틀 전달
      body: AccountBody(),
      bottomNavigationBar: Column()
      );
  }
}

// implements PreferredSizeWidget: 앱바 사이즈 지정
class MainAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  MainAppBar({required this.title}); //생성자

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
    );
  }

  @override
  // 앱바 사이즈 지정 - 기본 앱바 크기 (56.0 dp)
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class AccountBody extends StatefulWidget{
  @override
  _AccountBodyState createState() => _AccountBodyState();
}

class _AccountBodyState extends State<AccountBody>{

  @override
  Widget build(BuildContext context){
    return Center(
      child: Text('바디 영역 입니다'),
    );
  }
}