import 'package:get/get.dart';

class AccountController extends GetxController {
  //바디인덱스
  var bodyIndex = 0.obs;

  //출력할 바디 인덱스를 세팅
  void setBodyIndex(var index) {
    bodyIndex.value = index;
  }
}