import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_bleh/components/toggle_button.dart';
import 'package:project_bleh/constants.dart';
import 'package:project_bleh/network_helper/networkhelper.dart';

class Air extends StatefulWidget {
  static const String id = 'air';

  @override
  _AirState createState() => _AirState();
}

class _AirState extends State<Air> {
  NetworkHelper networkHelper = NetworkHelper();
  var switches;

  Future getInitStates() async {
    Map<String, dynamic> states = await networkHelper.getStates();
    return states;
  }

  Future<List<Widget>> createSwitches(Future states, String category) async {
    List<Widget> buttonList = [];
    Map<String, dynamic> s = await states;
    print("stattttte $s");
    s.forEach((key, value) {
      if (value["category"] == category) {
        buttonList.add(Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: ToggleButton(
            state: value["state"],
            title: value["name"],
            buttonColor:
                value["state"] ? kActiveButtonColor : kInactiveButtonColor,
            textColor:
                value["state"] ? kActiveContentColor : kInactiveContentColor,
            onTap: () {
              setState(() {
                switches = createSwitches(networkHelper.triggerPin(key), "air");
              });
            },
          ),
        ));
      }
    });
    print(buttonList);
    return buttonList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switches = createSwitches(getInitStates(), "air");
  }

  @override
  Widget build(BuildContext context) {
    if (switches != null) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Hero(
              tag: 'airIcon',
              child: Icon(
                FontAwesomeIcons.wind,
                size: kBigIconSize,
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
