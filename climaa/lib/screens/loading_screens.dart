import 'package:flutter/material.dart';
import 'package:climaa/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
   await location.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);
  }

  void getData() async {
    Uri uri = Uri.parse("https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b1b15e88fa797225412429c1c50c122a1");
    http.Response response = await http.get(uri);
    if(response.statusCode == 200){
      String data = response.body;
      var decodedData = jsonDecode(data);
      int condition = decodedData['weather'][0]['id'];
      double temperature = decodedData['main']['temp'];
      String city = decodedData['name'];
      print(condition);
      print(temperature);
      print(city);
    }else{
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold();
  }
}