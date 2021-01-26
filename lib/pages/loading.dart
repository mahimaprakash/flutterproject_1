import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setupWorldTime() async{
    WorldTime insta = WorldTime(location: 'Kolkata', flag: 'india.png', url: 'Asia/Kolkata');
    await insta.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': insta.location,
      'flag': insta.flag,
      'time': insta.time,
      'isDaytime': insta.isDaytime,
    });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.purple[100],
          size: 50.0,
        ),
      ),
    );
  }
}
