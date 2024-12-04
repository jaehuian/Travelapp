import 'dart:ui';

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
        scaffoldBackgroundColor: Colors.white, // 전체 배경 흰색
        // 전체적인 텍스트 스타일 설정
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: Color.fromRGBO(23, 30, 58, 1.0),
            fontFamily: 'default', // 사용자 정의 글꼴
          ),
          bodyMedium: TextStyle(
            color: Color.fromRGBO(23, 30, 58, 1.0),
            fontFamily: 'default',
          ),
          bodySmall: TextStyle(
            color: Color.fromRGBO(23, 30, 58, 1.0),
            fontFamily: 'default',
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white, // AppBar 배경색
          titleTextStyle: TextStyle(
              color: Color.fromRGBO(23, 30, 58, 1.0),
              fontFamily: 'default',
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
        )
      ),
      themeMode: ThemeMode.light, // 명시적으로 라이트 모드 사용
      home: MainBottomView(),
    );
  }
}
