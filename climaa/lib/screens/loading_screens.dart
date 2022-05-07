import 'package:climaa/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:climaa/services/location.dart';
import 'package:climaa/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = '57dcca946b53000b8f3cda88aa7bae23';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = Location();
   await location.getCurrentLocation();
    Uri url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric");
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(locationWeather: weatherData,);
    }));
  }

  @override
  Widget build(BuildContext context) {
    // getData(latitude, longitude);
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}