import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_bleh/components/toggle_button.dart';
import 'package:project_bleh/constants.dart';
import 'package:project_bleh/network_helper/networkhelper.dart';

class Lights extends StatefulWidget {
  static const String id = 'lights';

  @override
  _LightsState createState() => _LightsState();
}

class _LightsState extends State<Lights> {
  NetworkHelper networkHelper = NetworkHelper();
  var switches;
  var sliderValue = 0.0;
  bool sliderLock = false;

  Future getInitStates() async {
    Map<String, dynamic> states = await networkHelper.getStates();
    return states;
  }

  Future<List<Widget>> createSwitches(Future states, String category) async {
    List<Widget> buttonList = [];
    bool allFlag = true;
    List pinList = [];
    Map<String, dynamic> s = await states;
    //print("stattttte $s");
    s.forEach((key, value) {
      if (value["category"] == category) {
        pinList.add(key);
        allFlag = value["state"] & allFlag;
        print(allFlag);
        buttonList.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ToggleButton(
                state: value["state"],
                title: value["name"],
                buttonColor:
                    value["state"] ? kActiveButtonColor : kInactiveButtonColor,
                textColor: value["state"]
                    ? kActiveContentColor
                    : kInactiveContentColor,
                onTap: () {
                  setState(() {
                    switches =
                        createSwitches(networkHelper.triggerPin(key), "lights");
                  });
                },
              ),
              // SliderTheme(
              //   data: SliderTheme.of(context).copyWith(
              //     activeTrackColor: kIconColor2,
              //     inactiveTrackColor: Colors.black45,
              //     trackShape: RectangularSliderTrackShape(),
              //     trackHeight: 4.0,
              //     thumbColor: kIconColor2,
              //     thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
              //     overlayColor: Colors.black26,
              //     overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
              //   ),
              //   child: Slider(
              //     value: sliderValue,
              //     onChanged: (value) {
              //       setState(() {
              //         sliderValue = value;
              //       });
              //     },
              //   ),
              // ),
            ],
          ),
        );
      }
    });
    if (allFlag) {
      buttonList.add(Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: ToggleButton(
          state: allFlag,
          title: "Turn off all lights",
          buttonColor:
              allFlag ? kAllActiveButtonColor : kAllInactiveButtonColor,
          textColor:
              allFlag ? kAllActiveContentColor : kAllInactiveContentColor,
          onTap: () {
            setState(() {
              pinList.forEach((element) {
                if (s[element]["state"]) {
                  switches = createSwitches(
                      networkHelper.triggerPin(element), "lights");
                  allFlag = true;
                }
              });
            });
          },
        ),
      ));
    } else {
      buttonList.add(Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: ToggleButton(
          state: allFlag,
          title: "Turn on all lights",
          buttonColor:
              allFlag ? kAllActiveButtonColor : kAllInactiveButtonColor,
          textColor:
              allFlag ? kAllActiveContentColor : kAllInactiveContentColor,
          onTap: () {
            setState(() {
              pinList.forEach((element) {
                if (!s[element]["state"]) {
                  switches = createSwitches(
                      networkHelper.triggerPin(element), "lights");
                  allFlag = false;
                }
              });
            });
          },
        ),
      ));
    }
    //print(buttonList);
    return buttonList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switches = createSwitches(getInitStates(), "lights");
  }

  @override
  Widget build(BuildContext context) {
    if (switches != null) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.85,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Hero(
              tag: 'lightIcon',
              child: Icon(
                FontAwesomeIcons.lightbulb,
                size: kBigIconSize,
              ),
            ),
            Container(
              height: 30.0,
              alignment: Alignment.centerRight,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                onPressed: () {
                  setState(() {
                    sliderLock = !sliderLock;
                  });
                },
                child: Icon(
                  (sliderLock == true) ? Icons.lock : Icons.lock_open,
                  color: kIconColor2,
                  size: 30.0,
                ),
              ),
            ),
            FutureBuilder<List<Widget>>(
                future: switches,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Widget>> snapshot) {
                  List<Widget> children;
                  if (snapshot.hasData) {
                    children = snapshot.data;
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
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children,
                  );
                })
          ],
        ),
      );
    } else {
      return Text('Check connection');
    }
  }
}
