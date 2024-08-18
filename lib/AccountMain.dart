import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'defaultUI.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Account&Travel', //앱 이름
      home: TravelAppHome(title: '가계부'),
    );
  }
}

//가계부 홈화면 구조
class TravelAppHome extends StatelessWidget{
  final String title;
  const TravelAppHome({super.key, required this.title});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: MainAppBar(title: title), //'가계부' 타이틀 전달
      floatingActionButton: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AccountFloatButton(name: '달력'),
          AccountFloatButton(name: '거래내역'),
        ]
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      body: const AccountBody(),
      bottomNavigationBar: const MainBottom(),
      );
  }
}

class AccountFloatButton extends StatefulWidget{
  final String name;
  const AccountFloatButton({required this.name});

  @override
  _AccountFloatButtonState createState() => _AccountFloatButtonState(name);
}
class _AccountFloatButtonState extends State<AccountFloatButton>{
  String name;
  _AccountFloatButtonState(this.name);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 50,
      child:
      FloatingActionButton.extended(
        onPressed: (){},
        label: Text(name),
        backgroundColor: Colors.blue,
      ),
    );
  }

}