import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;  // Location Name For UI
  String time; // Time In That Location
  String flag; // URL To Asset Flag Icon
  String url; // Location URL for API Endpoint
  bool isDayTime; // True or False if Day Time or Not

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {

    try{
      // Make Request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);

      // Get Properties From Data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      // print(datetime);
      // print(offset);

      // Create DateTime Object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      // print(now);

      // Set Time Property
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false ;
      time = DateFormat.jm().format(now);

    }
    catch(e) {
      print('Caught Error : $e');
      time = 'Could Not Get Time Data';

    }

  }

}