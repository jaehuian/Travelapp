import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/router.dart';
import 'app/ui/components/defaultUI.dart';

void main() {
  // Flutter 엔진과 위젯 트리의 초기화를 보장합니다.
  WidgetsFlutterBinding.ensureInitialized();

  //앱실행
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Account&Travel', //앱 이름

      // 테마 설정
      theme: ThemeData(
        primarySwatch: Colors.blue, // 주요 색상 설정
        /*accentColor: Colors.amber, // 강조 색상
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.black, fontSize: 16),
          bodyText2: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue, // AppBar 배경색
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),

      home: MainBottomView(),
    );
  }
}
