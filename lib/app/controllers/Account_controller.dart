import 'package:get/get.dart';

class AccountController extends GetxController{
  //바디인덱스
  var bodyIndex = 0.obs;

  //출력할 바디 인덱스를 세팅
  void setBodyIndex(var index){
    bodyIndex.value = index;
  }
}

class CalendarController extends GetxController {
  var week = ["일", "월", "화", "수", "목", "금", "토"]; // 요일
  static DateTime now = DateTime.now(); // 현재 날짜

  RxInt year = 0.obs; // 년
  RxInt month = 0.obs; // 월
  RxList days = [].obs; // 일자

  // 수입 합계
  RxInt totalIncome = 0.obs;

  // 지출 합계
  RxInt totalExpense = 0.obs;

  // 선택된 날짜
  setPickedDay(int index) {
    for (var day in days) {
      day["picked"] = false.obs;
    }
    days[index]["picked"] = true.obs;
    days.refresh();
  }

  // 년, 월 설정 함수
  setFirst(int setYear, int setMonth) {
    year.value = setYear;
    month.value = setMonth;
    insertDays(year.value, month.value);
    updateIncomeExpense();  // 월 변경 시 합계 업데이트
  }

  // 이전 달로 이동
  void previousMonth() {
    if (month.value == 1) {
      year.value--;
      month.value = 12;
    } else {
      month.value--;
    }
    insertDays(year.value, month.value);
    updateIncomeExpense();  // 합계 업데이트
  }

  // 다음 달로 이동
  void nextMonth() {
    if (month.value == 12) {
      year.value++;
      month.value = 1;
    } else {
      month.value++;
    }
    insertDays(year.value, month.value);
    updateIncomeExpense();  // 합계 업데이트
  }

  // 수입 및 지출 합계 계산
  void updateIncomeExpense() {
    totalIncome.value = 0;  // 수입 초기화
    totalExpense.value = 0; // 지출 초기화

    for (var day in days) {
      if ((day["income"] != null)&&  day["inMonth"] ) {
        totalIncome.value += (day["income"] as num).toInt(); // num을 int로 변환하여 더함
      }
      if ((day["expense"] != null)&&  day["inMonth"] ) {
        totalExpense.value += (day["expense"] as num).toInt(); // num을 int로 변환하여 더함
      }
    }
  }

  // 일자 리스트 설정 함수
  insertDays(int year, int month) {
    days.clear();
    int lastDay = DateTime(year, month + 1, 0).day;

    // 해당 월의 일자 채우기
    for (var i = 1; i <= lastDay; i++) {
      days.add({
        "year": year,
        "month": month,
        "day": i,
        "income": 0,  // 예시로 고정된 수입
        "expense": 1000, // 예시로 고정된 지출
        "inMonth": true,
        "picked": false.obs,
      });
    }

    // 이전 달 일자 채우기
    if (DateTime(year, month, 1).weekday != 7) {
      var temp = [];
      int prevLastDay = DateTime(year, month, 0).day;
      for (var i = DateTime(year, month, 1).weekday - 1; i >= 0; i--) {
        temp.add({
          "year": month == 1 ? year - 1 : year,
          "month": month == 1 ? 12 : month - 1,
          "day": prevLastDay - i,
          "income": 2000,  // 예시로 고정된 수입
          "expense": 1000, // 예시로 고정된 지출
          "inMonth": false,
          "picked": false.obs,
        });
      }
      days = [...temp, ...days].obs;
    }

    // 다음 달 일자 채우기
    var temp = [];
    for (var i = 1; i <= 42 - days.length; i++) {
      temp.add({
        "year": month == 12 ? year + 1 : year,
        "month": month == 12 ? 1 : month + 1,
        "day": i,
        "income": 2000,  // 예시로 고정된 수입
        "expense": 1000, // 예시로 고정된 지출
        "inMonth": false,
        "picked": false.obs,
      });
    }
    days = [...days, ...temp].obs;

    updateIncomeExpense(); // 일자 추가 후 수입/지출 합계 업데이트
  }
}