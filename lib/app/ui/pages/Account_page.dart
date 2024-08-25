import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/defaultUI.dart';
import '../../controllers/Account_controller.dart';

//가계부 홈화면 구조
class AccountPage extends StatelessWidget{
  final String title;

  //가계부 컨트롤러 연결 (getX 사용)
  final AccountController controller = Get.put(AccountController());
  AccountPage({super.key, required this.title}); //가계부 타이틀 받아옴

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: MainAppBar(title: title), //'가계부' 타이틀 전달

      floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatButton(label: '달력', index: 0, controller: controller),
            FloatButton(label: '내역', index: 1, controller: controller),
            FloatButton(label: '분석', index: 2, controller: controller),
          ]
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, //플로팅 버튼 위치 

      body: Obx(() {
        return AccountBodyState(bodyIndex: controller.bodyIndex.value); //인덱스를 전달받아 body 화면을 그림
    }),

      bottomNavigationBar: const MainBottom(),
      );
  }
}

class AccountBodyState extends StatefulWidget{
  final int bodyIndex;
  const AccountBodyState({super.key, required this.bodyIndex}); //바디인덱스 받아옴

  @override
  _AccountBodyState createState() => _AccountBodyState();
}
class _AccountBodyState extends State<AccountBodyState>{

  //달력, 거래내역, 분석 화면 리스트
  List<Widget> currentBodies = <Widget>[const CalendarBody(), const HistoryBody(), const AnalyseBody()];

  @override
  Widget build(BuildContext context) {
    return currentBodies[widget.bodyIndex]; //핸재의 body 영역을 그림
  }
}

//달력 화면
class CalendarBody extends StatelessWidget {
  const CalendarBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('달력');
  }
}

//거래내역 화면
class HistoryBody extends StatelessWidget {
  const HistoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('거래내역');
  }
}

//분석 화면
class AnalyseBody extends StatelessWidget {
  const AnalyseBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('분석');
  }
}