import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './routes/router.dart';
import 'ui/components/defaultUI.dart';

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
      home: MainBottomView(),
    );
  }
}
