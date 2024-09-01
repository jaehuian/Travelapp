import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './routes/router.dart';

import 'ui/components/defaultUI.dart';

void main() {
  runApp(const MainPage());
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