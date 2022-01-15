import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherState with ChangeNotifier {
  String title = '';
  //String locationType = '';
  //String latLog = '';
  int woeId = 0;
  int temp = 0;
  String bg = 'clear';
  String iconName = 'c';

  void add(String value) {
    title += value;

    notifyListeners();
  }

  void fetchLocation(String value) async {

    if (value.isEmpty || value == '' || value == ' ') {
      value = 'Dhaka';
    }

    var apiUrl = Uri.parse('https://www.metaweather.com/api/location/search/?query=$value');

    var searchResponse = await http.get(apiUrl);

    if (searchResponse.statusCode == 200) {

      var result = json.decode(searchResponse.body);

      if(result.length > 0){

        title = result[0]['title'];
        woeId = result[0]['woeid'];

        var weatherAPI = Uri.parse('https://www.metaweather.com/api/location/$woeId');

        var response = await http.get(weatherAPI);

        if(response.statusCode == 200){

          var result = json.decode(response.body)['consolidated_weather'][0];

          temp = result['the_temp'].round();
          print('${result['the_temp'].round()} °C');
          String back = result['weather_state_name'].replaceAll(' ','').toLowerCase();
          if(back.isNotEmpty){
            bg = back;
          }

          iconName = result['weather_state_abbr'];

        }
      }
      else{
        title = 'No city found.';
        temp = 0;
      }

    } else {
      title = 'Something went wrong';
    }

    notifyListeners();
  }
}


