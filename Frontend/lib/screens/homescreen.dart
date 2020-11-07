import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:project_bleh/components/SquareButton.dart';
import 'package:project_bleh/components/weather_widgets.dart';
import 'package:project_bleh/constants.dart';
import 'package:project_bleh/network_helper/networkhelper.dart';
import 'package:project_bleh/screens/air.dart';
import 'package:project_bleh/screens/lights.dart';
import 'package:project_bleh/screens/rgb.dart';

class Homescreen extends StatefulWidget {
  static const String id = 'homescreen';

  @override
  _HomescreenState createState() => _HomescreenState();
}

//WeatherPropertyList weatherPropertyList = WeatherPropertyList();
var props, description, icon;
NetworkHelper networkHelper = NetworkHelper();
var weatherInfo;
String finalDate = '';

Future updateWeather() async {
  Map<String, dynamic> w = await networkHelper.getWeather();
  return w;
}

class _HomescreenState extends State<Homescreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weatherInfo = updateWeather();
    props = WeatherPropertyList().getWeatherPropertyList(weatherInfo);
    description =
        WeatherPropertyList().getWeatherDescriptionWidget(weatherInfo);
    icon = WeatherPropertyList().getWeatherIconWidget(weatherInfo);
    getCurrentDate();
  }

  getCurrentDate() {
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    setState(() {
      finalDate =
          "${dateParse.day}-${dateParse.month}-${dateParse.year}".toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 250.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(kTopModalBorderRadius),
                bottomRight: Radius.circular(kTopModalBorderRadius),
              ),
              color: kCardBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 70.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 94.0,
                        ),
                        child: Text(
                          '$finalDate',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                            color: kDarkDateColor,
                          ),
                        ),
                      ),
                      Row(
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FutureBuilder<Widget>(
                                future: icon,
                                builder: (BuildContext context,
                                    AsyncSnapshot<Widget> snapshot) {
                                  Widget child;
                                  if (snapshot.hasData) {
                                    child = snapshot.data;
                                    print(snapshot.data);
                                  } else if (snapshot.hasError) {
                                    child = Row(
                                      children: [
                                        Icon(
                                          Icons.error_outline,
                                          color: Colors.red,
                                          size: 60,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 16),
                                          child:
                                              Text('Error: ${snapshot.error}'),
                                        )
                                      ],
                                    );
                                  } else {
                                    child = SizedBox(
                                      child: CircularProgressIndicator(),
                                      width: 28,
                                      height: 60,
                                    );
                                  }
                                  return Container(
                                    child: child,
                                  );
                                }),
                          ),
                          SizedBox(
                            width: 18.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 16.0,
                            ),
                            child: FutureBuilder<Widget>(
                                future: description,
                                builder: (BuildContext context,
                                    AsyncSnapshot<Widget> snapshot) {
                                  Widget child;
                                  if (snapshot.hasData) {
                                    child = snapshot.data;
                                    print(snapshot.data);
                                  } else if (snapshot.hasError) {
                                    child = Row(
                                      children: [
                                        Icon(
                                          Icons.error_outline,
                                          color: Colors.red,
                                          size: 60,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 16),
                                          child:
                                              Text('Error: ${snapshot.error}'),
                                        )
                                      ],
                                    );
                                  } else {
                                    child = SizedBox(
                                      child: CircularProgressIndicator(),
                                      width: 30,
                                      height: 30,
                                    );
                                  }
                                  return Container(
                                    child: child,
                                  );
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                  FutureBuilder<List<Widget>>(
                      future: props,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Widget>> snapshot) {
                        List<Widget> children;
                        if (snapshot.hasData) {
                          children = snapshot.data;
                          print(snapshot.data);
                        } else if (snapshot.hasError) {
                          children = <Widget>[
                            Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 60,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text('Error: ${snapshot.error}'),
                            )
                          ];
                        } else {
                          children = <Widget>[
                            SizedBox(
                              child: CircularProgressIndicator(),
                              width: 60,
                              height: 60,
                            ),
                          ];
                        }
                        return Container(
                          height: 80.0,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: children,
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              bottom: 8.0,
              top: 32.0,
            ),
            child: Row(
              children: [
                Text(
                  'Welcome, ',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w200,
                    color: kLightTextColor,
                  ),
                ),
                Text(
                  'Dylan',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w700,
                    color: kLightTextColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SquareButton(
                      onTap: () {
                        showMaterialModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: kCardCircularRadius,
                            ),
                          ),
                          enableDrag: true,
                          isDismissible: true,
                          expand: false,
                          backgroundColor: Colors.white,
                          context: context,
                          bounce: true,
                          builder: (context) => Air(),
                        );
                      },
                      iconHeroTag: 'airIcon',
                      title: 'Air',
                      icon: Icon(
                        FontAwesomeIcons.wind,
                        size: kIconSize,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SquareButton(
                      onTap: () {
                        showMaterialModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: kCardCircularRadius,
                            ),
                          ),
                          enableDrag: true,
                          isDismissible: true,
                          expand: false,
                          backgroundColor: Colors.white,
                          context: context,
                          bounce: true,
                          builder: (context) => Lights(),
                        );
                      },
                      title: 'Lights',
                      iconHeroTag: 'lightIcon',
                      icon: Icon(
                        FontAwesomeIcons.lightbulb,
                        size: kIconSize,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: SquareButton(
                      onTap: () async {
                        print('pressed');
                        NetworkHelper networkHelper = NetworkHelper();
                        await networkHelper.triggerPin("38");
                      },
                      iconHeroTag: 'settingsIcon',
                      title: 'Settings',
                      icon: Icon(
                        FontAwesomeIcons.cog,
                        size: kIconSize,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SquareButton(
                      iconHeroTag: 'rgbIcon',
                      onTap: () {
                        showMaterialModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: kCardCircularRadius,
                            ),
                          ),
                          enableDrag: true,
                          isDismissible: true,
                          expand: false,
                          backgroundColor: Colors.white,
                          context: context,
                          bounce: true,
                          builder: (context) => RGB(),
                        );
                      },
                      title: 'RGB Strip',
                      icon: Icon(
                        FontAwesomeIcons.trafficLight,
                        size: kIconSize,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//Icon(
//Icons.cloud_circle,
//size: 55.0,
//color: kDarkTextColor,
//),
