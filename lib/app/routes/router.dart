import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ui/pages/Account_page.dart';
import '../ui/pages/Travel_page.dart';

class MainRouter {
  static final List<Widget> widgetOptions = <Widget>[
    AccountPage(),
    TravelPage(),
  ];
}
class AppRouter {
  static final pages = [
    //
  ];
}
