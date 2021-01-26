import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; //location name for the UI
  String time; //time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api endpoints
  bool isDaytime;

  WorldTime({ this.location, this.flag, this.url});

  Future<void> getTime() async {

    try{
      // make the request
      Response response = await get(
          'http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offsethour = data['utc_offset'].substring(1, 3);
      String offsetmin = data['utc_offset'].substring(4,6);

      print(datetime);
      //print(data['utc_offset']);

      //create a datetime object
      DateTime now = DateTime.parse(datetime);
      if(data['utc_offset'].substring(0) == '+'){
        now = now.add(Duration(hours: int.parse(offsethour)));
        now = now.add(Duration(minutes: int.parse(offsetmin)));
      }
      else{
        now = now.subtract(Duration(hours: int.parse(offsethour)));
        now = now.subtract(Duration(minutes: int.parse(offsetmin)));
      }


      //set the time property
      isDaytime = now.hour > 6 && now.hour < 18 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(e) {
      print('caught error: $e');
      time = 'couldnot get the time';
    }


  }
}


