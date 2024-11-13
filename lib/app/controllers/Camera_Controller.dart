import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraControllerX extends GetxController with WidgetsBindingObserver {
  late CameraController _controller;
  late Future<void> initializeControllerFuture; //카메라 초기화
  var isCameraPermissionGranted = false.obs; // 카메라 권한

  @override
  void onInit() {
    WidgetsBinding.instance?.addObserver(this);
    super.onInit();
    _checkCameraPermission(); // 카메라 권한 확인
  }

  // 카메라 권한 확인 및 요청
  Future<void> _checkCameraPermission() async {
    var status = await Permission.camera.status;

    if (status.isGranted) {
      isCameraPermissionGranted.value = true;
      _initializeCamera(); // 권한이 있을 때 카메라 초기화
    } else {
      // 권한이 없으면 요청
      if (await Permission.camera.request().isGranted) {
        isCameraPermissionGranted.value = true;
        _initializeCamera();
      } else {
        // 권한 거부 시 처리
        isCameraPermissionGranted.value = false;
        print("카메라 권한이 필요합니다.");
      }
    }
  }

  // 카메라 초기화
  Future<void> _initializeCamera() async {
    if (!isCameraPermissionGranted.value) return; // 권한 없으면 종료
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    try {
      //카메라 목록 내 첫번째 카메라 사용, 촬영 품질 높음
      _controller = CameraController(
        firstCamera,
        ResolutionPreset.high,
      );
      initializeControllerFuture = _controller.initialize(); //카메라 초기화
      update(); // 상태 갱신
    }catch (e) {
      print('카메라 초기화 오류: $e');
      initializeControllerFuture = Future.error(e); // 에러 발생 시 Future에 에러 할당
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance?.removeObserver(this);
    _controller.dispose();
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // 앱이 일시정지 상태가 되면 카메라 컨트롤러 해제
      _controller.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // 앱이 다시 활성화 상태로 돌아오면 권한을 확인 후 초기화
      _checkCameraPermission();
      if (isCameraPermissionGranted.value && !_controller.value.isInitialized) {
        // 카메라가 아직 초기화되지 않았을 때만 초기화
        _initializeCamera();
      }
    }
  }

  CameraController get controller => _controller;
}