import 'package:get/get.dart';

class AccountController extends GetxController {
  //바디인덱스
  var bodyIndex = 0.obs;

  //출력할 바디 인덱스를 세팅
  void setBodyIndex(var index) {
    bodyIndex.value = index;
  }
  // 화면을 변경하는 함수
  void changeBody(int index) {
    bodyIndex.value = index;  // index 값을 받아서 bodyIndex를 업데이트
  }
}

class CalendarController extends GetxController{
  var week = ["일", "월", "화", "수", "목", "금", "토"]; // 요일
  static DateTime now = DateTime.now(); // 현재 날짜

  RxInt year = 0.obs; // 년
  RxInt month = 0.obs; // 월
  RxList days = [].obs; // 일자

  setPickedDay(int index) {
    for(var day in days){
      day["picked"] = false.obs;
    }
    days[index]["picked"] = true.obs;
    days.refresh();
  }

  // 년, 월, 일 설정 함수
  setFirst(int setYear, int setMonth) {
    year.value = setYear;
    month.value = setMonth;
    insertDays(year.value, month.value); // 설정한 년도와 월에 맞는 일자 리스트 설정 함수
  }
  // 일자 리스트 설정 함수
  insertDays(int year, int month) {
    days.clear(); // 일자 리스트 초기화
    int lastDay = DateTime(year, month + 1, 0).day;
    // 해당 월의 일자 채우기
    for (var i = 1; i <= lastDay; i++) {
      days.add({
        "year": year,
        "month": month,
        "day": i,
        "income": 2000,
        "expense": 1000,
        "inMonth": true,
        "picked": false.obs,
      });
    }

    // 해당 월의 1일 앞에 빈칸이 있으면 이전 달 마지막 날짜까지 채우기
    if (DateTime(year, month, 1).weekday != 7) {
      var temp = [];
      int prevLastDay = DateTime(year, month, 0).day;
      for (var i = DateTime(year, month, 1).weekday - 1; i >= 0; i--) {
        temp.add({
          "year": year,
          "month": month - 1,
          "day": prevLastDay - i,
          "income": 2000,
          "expense": 1000,
          "inMonth": false,
          "picked": false.obs,
        });
      }
      days = [...temp, ...days].obs;
    }

    // 해당 월의 마지막 일자 뒤에 빈칸이 있으면 다음 달 1일부터 빈칸까지 채우기
    var temp = [];
    for (var i = 1; i <= 42 - days.length; i++) {
      temp.add({
        "year": year,
        "month": month + 1,
        "day": i,
        "income": 2000,
        "expense": 1000,
        "inMonth": false,
        "picked": false.obs,
      });
    }

    days = [...days, ...temp].obs;
  }
}