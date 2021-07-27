import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class WorldTime{

  int seconds = 0;
  String location;        // location area
  String time = "";       // real time String
  String flag;           // country icon
  String url;             // url to get location time
  bool isDayTime = true;  // true or false if daytime or not

  WorldTime({ required this.location, required this.flag, required this.url});

  Future<void> getData() async{

    try {
      // get the data
      Response response = await get(
          Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      // find information from data
      DateTime now = DateTime.parse(data['utc_datetime']);
      String offset = data['utc_offset'].substring(1, 3);

      // add the offset to the time
      now = now.add(Duration(hours: int.parse(offset)));

      // to String
      time = DateFormat('HH:mm').format(now);

      // update for the rest time
      seconds = int.parse(DateFormat('ss').format(now));

      // is DayTime or not
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
    }
    catch(e){
      print('error: $e');
      time = "some error caught";
    }
  }
  Map getInfo() => {'location': this.location, 'time': this.time, 'flag': this.flag, 'isDayTime': this.isDayTime, 'seconds': this.seconds};
}