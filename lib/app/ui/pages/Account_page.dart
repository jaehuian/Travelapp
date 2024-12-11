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
          children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  border: Border(
                    left: BorderSide(color: Color.fromRGBO(73,117,192, 1.0), width: 1), // 왼쪽 테두리
                    right: BorderSide(color: Color.fromRGBO(73,117,192, 1.0), width: 1), // 오른쪽 테두리
                  ),
                ),
              child: CustomFloatingButton(
                label: '달력',
                icon: Icons.calendar_today,
                onPressed: () => controller.changeBody(0),
              )),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  border: Border(
                    left: BorderSide(color: Color.fromRGBO(73,117,192, 1.0), width: 1), // 왼쪽 테두리
                    right: BorderSide(color: Color.fromRGBO(73,117,192, 1.0), width: 1), // 오른쪽 테두리
                  ),),
                child: CustomFloatingButton(
                  label: '내역',
                  icon: Icons.list,
                  onPressed: () => controller.changeBody(1),
                )),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  border: Border(
                    left: BorderSide(color: Color.fromRGBO(73,117,192, 1.0), width: 1), // 왼쪽 테두리
                    right: BorderSide(color: Color.fromRGBO(73,117,192, 1.0), width: 1), // 오른쪽 테두리
                  ),),
                child: CustomFloatingButton(
                  label: '분석',
                  icon: Icons.list,
                  onPressed: () => controller.changeBody(2),
                )),
          ],
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, //플로팅 버튼 위치

      body: Obx(() {
        return AccountBodyState(bodyIndex: controller.bodyIndex.value); //인덱스를 전달받아 body 화면을 그림
    }),
      );
  }
}

class AccountBodyState extends StatefulWidget {
  final int bodyIndex;

  const AccountBodyState({super.key, required this.bodyIndex}); //바디인덱스 받아옴

  @override
  _AccountBodyState createState() => _AccountBodyState();
}

class _AccountBodyState extends State<AccountBodyState> {
  //달력, 거래내역, 분석 화면 리스트
  List<Widget> currentBodies = <Widget>[
    const CalendarBody(),
    const HistoryBody(),
    const AnalyseBody()
  ];

  @override
  Widget build(BuildContext context) {
    return currentBodies[widget.bodyIndex]; //핸재의 body 영역을 그림
  }
}

class CustomFloatingButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const CustomFloatingButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child:  Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
          children: [
            Text(
              label,
              style: const TextStyle(color: Color.fromRGBO(23, 30, 58, 1.0)),
            ),
          ],
        ),
    );
  }
}
//달력 화면
class CalendarBody extends StatelessWidget {
  const CalendarBody({super.key});

  @override
  Widget build(BuildContext context) {
    final CalendarController controller = Get.put(CalendarController());
    controller.setFirst(2024, 8);
    return Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 350,
          height: 600,
          child: Obx(
                () => GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 5,
                crossAxisSpacing: 0,
              ),
              itemCount: controller.days.length,
              itemBuilder: (context, i) => InkWell(
                onTap: () => controller.setPickedDay(i),
                child: Stack(
                  children: [
                    // 배경 색상 (선택된 날짜일 경우)
                    Container(
                      width: 50,
                      height: 100,
                      color: controller.days[i]["picked"].value ? Colors.red : Colors.transparent,
                    ),
                    // 날짜 표시 (왼쪽 상단)
                    Positioned(
                      top: 0,
                      left: 5,
                      child: Text(
                        controller.days[i]["day"].toString(),
                        style: TextStyle(
                          color: controller.days[i]["inMonth"] ? Colors.black : Colors.grey,
                        ),
                      ),
                    ),
                    // 수입과 지출 표시 (오른쪽 하단)
                    Positioned(
                      bottom: 0,
                      right: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // 수입 표시
                          if (controller.days[i]["income"] != null)
                            Text(
                              "+${controller.days[i]["income"]}",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          // 지출 표시
                          if (controller.days[i]["expense"] != null)
                            Text(
                              "-${controller.days[i]["expense"]}",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
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