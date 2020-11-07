import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_bleh/constants.dart';

Map<String, dynamic> weatherInfo;

class WeatherPropertyList {
  Future<List<Widget>> getWeatherPropertyList(Future weatherInfo) async {
    print(weatherInfo);
    Map<String, dynamic> w = await weatherInfo;
    List<Widget> widgetList = [];
    w.forEach((key, value) {
      print(key);
      if (key != "Description") {
        Widget newWidget = Container(
          height: 30.0,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      value["value"].toString(),
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      value["unit"],
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ],
                ),
                Text(
                  key,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ],
            ),
          ),
        );
        widgetList.add(newWidget);
        print(key);
      }
    });
    return widgetList;
  }

  Future<Widget> getWeatherDescriptionWidget(Future weatherInfo) async {
    print(weatherInfo);
    Map<String, dynamic> w = await weatherInfo;
    return Text(
      w["Description"]["value"],
      style: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.w500,
        color: kDarkTextColor,
      ),
    );
  }

//  Widget iconWidget({IconData icon}) {
//    return Padding(
//      padding: const EdgeInsets.all(8.0),
//      child: Icon(
//        icon,
//        size: 55.0,
//        color: kDarkTextColor,
//      ),
//    );
//  }

  Future<Widget> getWeatherIconWidget(Future weatherInfo) async {
    print(weatherInfo);
    Map<String, dynamic> w = await weatherInfo;
    String icon = w["Description"]["icon"];
    print(icon);
    return Container(
      height: 60.0,
      width: 60.0,
      child: Image.network(
        'http://openweathermap.org/img/wn/$icon@2x.png',
      ),
    );
  }
}
