import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/defaultUI.dart';
import '../../controllers/Account_controller.dart';

//가계부 홈화면 구조
class AccountPage extends StatelessWidget {
  //가계부 컨트롤러 연결 (getX 사용)
  final AccountController controller = Get.put(AccountController());

  AccountPage({super.key}); //가계부 타이틀 받아옴

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(title: '가계부'),
      //'가계부' 타이틀 전달

      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        FloatButton(label: '달력', index: 0, controller: controller),
        FloatButton(label: '내역', index: 1, controller: controller),
        FloatButton(label: '분석', index: 2, controller: controller),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //플로팅 버튼 위치

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

//달력 화면
class CalendarBody extends StatelessWidget {
  const CalendarBody({super.key});

  @override
  Widget build(BuildContext context) {
    final CalendarController controller = Get.put(CalendarController());
    controller.setFirst(2024, 8);

    return Column(
      children: [
        // 상단 네비게이션
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_left),
              onPressed: () => controller.previousMonth(),
            ),
            Obx(() => TextButton(
              onPressed: () => _showYearMonthPicker(context, controller),
              child: Text(
                "${controller.year.value}년 ${controller.month.value}월",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )),
            IconButton(
              icon: Icon(Icons.arrow_right),
              onPressed: () => controller.nextMonth(),
            ),
          ],
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
    return const Text('분석');
  }
}




