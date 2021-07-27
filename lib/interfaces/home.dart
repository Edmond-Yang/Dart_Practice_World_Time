import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map info = {};

  void setTime(){
    int waitSecond = 60 - info['seconds'] - 1 as int;

    Future.delayed(Duration(seconds: waitSecond),(){

      int hour = int.parse(info['time'].substring(0,2));
      int minute = int.parse(info['time'].substring(3,5));

      minute = minute == 59 ? 00 : minute + 1;
      hour = minute != 00 ? hour : hour == 23 ? 00 : hour + 1;

      setState(() {

        if(hour>=10 && minute>=10)
          info['time'] = '$hour:$minute';
        else if(hour<10 && minute>=10)
          info['time'] = '0$hour:$minute';
        else if(hour>=10 && minute<10)
          info['time'] = '$hour:0$minute';
        else
          info['time'] = '0$hour:0$minute';
      });

        info['seconds'] = 0 ;

    });
  }

  @override
  Widget build(BuildContext context) {

    info = info.isEmpty ? ModalRoute.of(context)!.settings.arguments as Map : info;
    String bgImage = info['isDayTime'] ? 'day.png' : 'night.png';
    Color bgColor = info['isDayTime'] ? Colors.blue : Colors.indigo;

    setTime();

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: Column(
                  children: <Widget>[
                    TextButton.icon(
                      onPressed: ()async{
                        dynamic data = await Navigator.pushNamed(context, '/location', arguments: bgColor) ;
                        setState(() {
                          info['location'] = data['location'];
                          info['time'] =  data['time'];
                          info['flag'] = data['flag'];
                          info['isDayTime']= data['isDayTime'];
                          info['seconds']= data['seconds'];
                        });
                      },
                      icon: Icon(Icons.edit_location,color: Colors.grey[200],),
                      label: Text('edit location',
                        style: TextStyle(
                          color: Colors.grey[200],
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Text(info['location'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontFamily: 'SegoeUI',
                      )
                    ),
                    Text(info['time'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 80.0,
                          fontFamily: 'SegoeUI',
                        )
                    ),
                  ],
                ),
              ),
          ),
        ),
      ),
    );
  }
}
