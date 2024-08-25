import 'package:flutter/material.dart';
import '../components/defaultUI.dart';

//여행탭 홈화면 구조
class TravelPage extends StatelessWidget{
  const TravelPage({super.key});

  @override
  Widget build(BuildContext context){
    return const Scaffold(
      appBar: MainAppBar(title: '여행'), //'여행' 타이틀 전달
      body: TravelBody(),
    );
  }
}

//여행 바디
class TravelBody extends StatefulWidget{
  const TravelBody({super.key});

  @override
  State<TravelBody> createState() => _TravelBodyState();
}

class _TravelBodyState extends State<TravelBody>{

  @override
  Widget build(BuildContext context){
    return const Center(
      child: Text('여행 바디 영역 입니다'),
    );
  }
}