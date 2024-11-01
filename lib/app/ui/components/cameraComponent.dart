import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gallery_saver/gallery_saver.dart'; // 갤러리에 저장하기 위한 패키지
import '../../controllers/Camera_Controller.dart'; //카메라 컨트롤러 가져오기

class CameraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cameraControllerX = Get.put(CameraControllerX());

    return Scaffold(
      body: GetBuilder<CameraControllerX>(
        builder: (controller) {
          // 카메라 권한이 없을 경우 메시지 출력
          if (!controller.isCameraPermissionGranted.value) {
            return Center(child: Text('카메라 권한이 필요합니다.'));
          }
          //카메라 초기화 안되면 로딩 인디케이터 노출
          if (controller.initializeControllerFuture == null) {
            return Center(child: CircularProgressIndicator());
          }
          return FutureBuilder<void>(
          future: cameraControllerX.initializeControllerFuture, //카메라 초기화
          builder: (context, snapshot) {
            // 초기화 완료 시 카메라 프리뷰 표시
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(cameraControllerX.controller);
            } else if (snapshot.hasError) {
              return Center(child: Text('카메라 초기화 실패: ${snapshot.error}'));
            } else {
              // 초기화 중일 경우 로딩 아이콘 표시
              return Center(child: CircularProgressIndicator());
            }
          },
        );}),
      //촬영 버튼
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          // 카메라 초기화가 되었는지 확인
          if (cameraControllerX.initializeControllerFuture == null) {
            print('카메라가 초기화되지 않았습니다.');
            return;
          }

          try {
            // 카메라가 초기화된 상태에서 사진 촬영
            await cameraControllerX.initializeControllerFuture;
            final image = await cameraControllerX.controller.takePicture();
            print('사진 저장 경로: ${image.path}');

            // 촬영된 사진을 갤러리에 저장
            await GallerySaver.saveImage(image.path, albumName: 'MyCameraApp');
            print('사진이 갤러리에 저장되었습니다.');
          } catch (e) {
            print('사진 촬영 오류: $e');
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, //촬영 버튼 위치
    );
  }
}