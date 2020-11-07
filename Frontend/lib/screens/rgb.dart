import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_bleh/components/toggle_button.dart';
import 'package:project_bleh/constants.dart';
import 'package:project_bleh/network_helper/networkhelper.dart';

class RGB extends StatefulWidget {
  @override
  _RGBState createState() => _RGBState();
}

class _RGBState extends State<RGB> {
  NetworkHelper networkHelper = NetworkHelper();
  var switches;
  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

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
        print("RGB FOUND");
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
                switches = createSwitches(networkHelper.triggerPin(key), "rgb");
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
    switches = createSwitches(getInitStates(), "rgb");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Hero(
            tag: 'rgbIcon',
            child: Icon(
              FontAwesomeIcons.trafficLight,
              size: kBigIconSize,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: ColorPicker(
              paletteType: PaletteType.hsl,
              enableAlpha: false,
              pickerColor: pickerColor,
              onColorChanged: (value) {
                currentColor = value;
                print(value);
              },
              showLabel: false,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          FutureBuilder<List<Widget>>(
              future: switches,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
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
  }
}
