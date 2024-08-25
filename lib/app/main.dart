import 'package:flutter/material.dart';
import '/app/ui/pages/Account_page.dart';

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
      home: AccountPage(title: '가계부'), //가계부 페이지 그리기
    );
  }
}