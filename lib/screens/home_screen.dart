import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/components/constant.dart';
import 'package:weather_app/states/weather_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherState>(builder: (context, weatherState, child) {
      return GestureDetector(
        onTap: ()=> FocusScope.of(context).unfocus(),
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/${weatherState.bg}.png'),
            fit: BoxFit.cover,
          )),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Center(
                      child: weatherState.title == '' ? CircularProgressIndicator() : Image.asset(
                        'images/${weatherState.iconName}.png',
                        height: 60.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: Text(
                        '${weatherState.temp} °C',
                        style: textStyle.copyWith(
                          fontSize: 65.0,
                        )
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        weatherState.title,
                        style: textStyle.copyWith(
                          fontSize: 35.0,
                        )
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 300,
                      child: TextFormField(
                        onChanged: (value) {
                          weatherState.fetchLocation(value);
                        },
                        decoration: InputDecoration(
                            hintText: 'Search a city',
                            fillColor: Colors.white,
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                            suffixIcon: Icon(
                              Icons.search_rounded,
                              color: Colors.white,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
