import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [
      WorldTime(url: 'Asia/Taipei', location: 'Taipei', flag: 'taiwan.png'),
      WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
      WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
      WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
      WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
      WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
      WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
      WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
      WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];

  void setLocation(int index) async {

    WorldTime instance = locations[index];

    Future.delayed(Duration(seconds: 2), (){
      Navigator.pop(context, instance.getInfo());
    });

    await instance.getData();

  }

  @override
  Widget build(BuildContext context) {

    Color appBarColor = ModalRoute.of(context)!.settings.arguments as Color;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Choose Location'),
        centerTitle: true,
        backgroundColor: appBarColor,
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context,index){
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
              child: ListTile(
                tileColor: Colors.white,
                onTap: (){
                  setLocation(index);
                },
                title: Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: Text('${locations[index].location}',
                    style: TextStyle(
                      fontFamily: 'SegoeUI',
                      fontSize: 19,
                    )
                  ),
                ),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/${locations[index].flag}'),
                ),
              ),
            );
          }),
    );
  }
}
