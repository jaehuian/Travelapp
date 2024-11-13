import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/defaultUI.dart';
import '../components/cameraComponent.dart';
import '../../controllers/Account_controller.dart';

//가계부 홈화면 구조
class AccountPage extends StatelessWidget{
  //가계부 컨트롤러 연결 (getX 사용)
  final AccountController controller = Get.put(AccountController());
  AccountPage({super.key}); //가계부 타이틀 받아옴

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: const MainAppBar(title: '가계부'), //'가계부' 타이틀 전달

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            heroTag: '달력Button', // heroTag 설정
            onPressed: () {
              controller.changeBody(0);
            },
            child: Text('달력'),
          ),
          FloatingActionButton(
            heroTag: '내역Button',
            onPressed: () {
              controller.changeBody(1);
            },
            child: Text('내역'),
          ),
          FloatingActionButton(
            heroTag: '분석Button',
            onPressed: () {
              controller.changeBody(2);
            },
            child: Text('분석'),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, //플로팅 버튼 위치 

      body: Obx(() {
        return AccountBodyState(bodyIndex: controller.bodyIndex.value); //인덱스를 전달받아 body 화면을 그림
    }),
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

    return Row(
      children: [
        Text('분석'), // 텍스트 위젯
        ElevatedButton(
          onPressed: () async {
            Get.to(() => CameraApp()); //카메라 화면 이동
          },
          child: Icon(Icons.camera_alt),
        ),
      ],
    );
  }
}