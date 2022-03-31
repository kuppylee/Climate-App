import 'package:climaa/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:climaa/services/location.dart';
import 'package:climaa/services/networking.dart';


const apiKey = '57dcca946b53000b8f3cda88aa7bae23';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  late double longitude;
  late double latitude;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = Location();
   await location.getCurrentLocation();
   latitude = location.latitude;
   longitude =location.longitude;
    Uri url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey");
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    // getData(latitude, longitude);
    return Scaffold();
  }
}