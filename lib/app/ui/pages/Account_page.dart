import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/defaultUI.dart';
import '../components/cameraComponent.dart';
import '../../controllers/Account_controller.dart';

//가계부 홈화면 구조
class AccountPage extends StatelessWidget {
  //가계부 컨트롤러 연결 (getX 사용)
  final AccountController controller = Get.put(AccountController());

  AccountPage({super.key}); //가계부 타이틀 받아옴

  @override
  Widget build(BuildContext context) {
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
        return AccountBodyState(
            bodyIndex: controller.bodyIndex.value); //인덱스를 전달받아 body 화면을 그림
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
class YearMonthNavigation extends StatelessWidget {
  final CalendarController controller;
  final VoidCallback onYearMonthPickerTap;

  const YearMonthNavigation({
    required this.controller,
    required this.onYearMonthPickerTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
      children: [
        // 년/월 네비게이션
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_left, color: Colors.black),
              onPressed: () => controller.previousMonth(),
            ),
            Obx(() => TextButton(
              onPressed: onYearMonthPickerTap,
              child: Text(
                "${controller.year.value}년 ${controller.month.value}월",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            )),
            IconButton(
              icon: const Icon(Icons.arrow_right, color: Colors.black),
              onPressed: () => controller.nextMonth(),
            ),
          ],
        ),

        // 수입/지출 표시 부분
        Obx(() => Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 지출
              Row(
                children: [
                  Text(
                    "지출 ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800], // 회색
                    ),
                  ),
                  Text(
                    "${controller.totalExpense.value}원",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue, // 주황색
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4), // 간격
              // 수입
              Row(
                children: [
                  Text(
                    "수입 ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800], // 회색
                    ),
                  ),
                  Text(
                    "${controller.totalIncome.value}원",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange, // 파란색
                    ),
                  ),
                ],
              ),
            ],
          ),
        )),
      ],
    );
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

    return Column(
      children: [
        // YearMonthNavigation 공통 위젯
        YearMonthNavigation(
          controller: controller,
          onYearMonthPickerTap: () => _showYearMonthPicker(context, controller),
        ),

        // 달력 (요일 포함)
        Expanded(
          child: Obx(() => GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7, // 7열 고정
              mainAxisSpacing: 5,
              crossAxisSpacing: 0,
            ),
            itemCount: controller.week.length + controller.days.length, // 요일 + 날짜
            itemBuilder: (context, i) {
              // 요일 표시
              if (i < controller.week.length) {
                return Center(
                  child: Text(
                    controller.week[i],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: i == 0
                          ? Colors.red // 일요일 빨간색
                          : i == 6
                          ? Colors.blue // 토요일 파란색
                          : Colors.black, // 나머지 검은색
                    ),
                  ),
                );
              }

              // 날짜 표시
              int dayIndex = i - controller.week.length;
              return InkWell(
                onTap: () => controller.setPickedDay(dayIndex),
                child: Stack(
                  children: [
                    // 배경 색상
                    Container(
                      color: controller.days[dayIndex]["picked"].value
                          ? Colors.red
                          : Colors.transparent,
                    ),
                    // 날짜 표시
                    Positioned(
                      top: 5,
                      left: 5,
                      child: Text(
                        controller.days[dayIndex]["day"].toString(),
                        style: TextStyle(
                          color: controller.days[dayIndex]["inMonth"]
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (controller.days[dayIndex]["income"] != null)
                            Text(
                              "+${controller.days[dayIndex]["income"]}",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          if (controller.days[dayIndex]["expense"] != null)
                            Text(
                              "-${controller.days[dayIndex]["expense"]}",
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
              );
            },
          )),
        ),
      ],
    );
  }

  // BottomSheet 생성 함수
  void _showYearMonthPicker(BuildContext context, CalendarController controller) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 년도 선택
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_left),
                    onPressed: () {
                      controller.year.value -= 1;
                    },
                  ),
                  Obx(() => Text(
                    "${controller.year.value}년",
                    style: TextStyle(fontSize: 20),
                  )),
                  IconButton(
                    icon: Icon(Icons.arrow_right),
                    onPressed: () {
                      controller.year.value += 1;
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              // 월 선택
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                itemCount: 12,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      controller.month.value = i + 1;
                      controller.insertDays(controller.year.value, controller.month.value);
                      Navigator.pop(context); // BottomSheet 닫기
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: i + 1 == controller.month.value ? Colors.blue : Colors.grey[200],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "${i + 1}월",
                        style: TextStyle(
                          color: i + 1 == controller.month.value ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
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




