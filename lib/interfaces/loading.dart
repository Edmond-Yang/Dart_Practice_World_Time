import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  @override
  void initState(){
    super.initState();
    setTime();
  }

  void setTime() async{
    WorldTime instance = new WorldTime(location: 'Taipei', flag: 'Taiwan.png', url: "Asia/Taipei");

    Future.delayed(Duration(seconds: 2), (){
      Navigator.pushReplacementNamed(context, '/home', arguments: instance.getInfo());
    });

    await instance.getData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: SpinKitRipple(
          size: 200.0,
          color: Colors.white,
        )
      ),
    );
  }
}
