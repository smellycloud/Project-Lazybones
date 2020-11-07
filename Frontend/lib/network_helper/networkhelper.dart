import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  String ip = "http://10.0.0.14:7000";

  Future triggerPin(String pin) async {
    String url = ip+'/toggle/'+pin;
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      print(map);
      return map;
    } else {
      print(response.statusCode);
    }
  }

  Future getStates() async {
    String url = ip+'/states';
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      //var decodedData = jsonDecode(response.body);
      Map<String, dynamic> map = json.decode(response.body);
      print(map);
      return map;
    } else {
      print(response.statusCode);
    }
  }

  Future getWeather() async {
    String url = ip+'/appweather';
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      //var decodedData = jsonDecode(response.body);
      Map<String, dynamic> map = json.decode(response.body);
      //print(map);
      return map;
    } else {
      print(response.statusCode);
    }
  }


}