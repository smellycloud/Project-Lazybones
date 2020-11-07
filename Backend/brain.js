const writePin = require('./pin_modules/writePin');
const readPin = require('./pin_modules/readPin');
require('dotenv').config();
const express = require('express');
const app = express();
var weather = require('openweather-apis');
weather.setLang('en');
weather.setCity('YOUR_CITY');
//weather.setZipCode(560008);
weather.setAPPID('YOUR_API_KEY');

statesJSON = {
    29: {
        "id": 1,
        "name": "Spotlight 1",
        "state": false,
        "category" : "lights",
    },
    31: {
        "id": 2,
        "name": "Spotlight 2",
        "state": false,
        "category" : "lights",
    },
    32: {
        "id": 3,
        "name": "Spotlight 3",
        "state": false,
        "category" : "lights",
    },
    33: {
        "id": 4,
        "name": "Spotlight 4",
        "state": false,
        "category" : "lights",
    },
    35: {
        "id": 5,
        "name": "Spotlight 5",
        "state": false,
        "category" : "lights",
    },
    37: {
        "id": 6,
        "name": "Ceiling Fan",
        "state": false,
        "category" : "air",
    },
    38: {
        "id": 7,
        "name": "RGB Light Strip",
        "state": false,
        "category" : "rgb",
        "hex": "000000",
    },
}

weatherInfo = {
  "Description" : {
    "value": "moo",
    "code" : "100",
    "icon" : "lol"
  },
  "Indoor Temperature": {
    "value": 23,
    "unit": "˚C",
  },
  "Outdoor Temperature": {
    "value": 23,
    "unit": "˚C",
  },
  "Max. Outdoor Temperature": {
    "value": 23,
    "unit": "˚C",
  },
  "Min. Outdoor Temperature": {
    "value": 23,
    "unit": "˚C",
  },
  "Outdoor Humidity": {
    "value": 48.2,
    "unit": "%",
  },
  "Wind Speed": {
    "value": 23,
    "unit": "km/h",
  },
  "Pressure": {
    "value": 0.012,
    "unit": "millibars",
  },
};

writePin.writePin(38, 1);
console.log(readPin.readPin(38));

app.get('/toggle/:pin', function(req, res) {
  try {
    console.log(req.params.pin);
    currentPin = parseInt(req.params.pin);
    if(readPin.readPin(currentPin) === false) {
      writePin.writePin(currentPin, true);
      statesJSON[currentPin]["state"] = readPin.readPin(currentPin);
    } else {
      writePin.writePin(currentPin, false);
      statesJSON[currentPin]["state"] = readPin.readPin(currentPin);
    }
    res.send(statesJSON);
  } catch (e) {
    console.log(e);
    res.status(400);
  }
});

app.get('/raweather', function(req, res) {
  try {
    weather.getAllWeather(function(err, JSONObj){
        res.send(JSONObj)
    });
  } catch(e) {
    console.log(e);
  }
});


app.get('/appweather', function(req, res) {
  try {
    weather.getAllWeather(function(err, JSONObj){
        weatherInfo["Description"]["code"] = JSONObj["weather"][0]["id"];
        weatherInfo["Description"]["value"] = JSONObj["weather"][0]["description"];
        weatherInfo["Description"]["icon"] = JSONObj["weather"][0]["icon"];
        weatherInfo["Outdoor Temperature"]["value"] = JSONObj["main"]["temp"];
        weatherInfo["Max. Outdoor Temperature"]["value"] = JSONObj["main"]["temp_max"];
        weatherInfo["Min. Outdoor Temperature"]["value"] = JSONObj["main"]["temp_min"];
        weatherInfo["Outdoor Humidity"]["value"] = JSONObj["main"]["humidity"];
        weatherInfo["Wind Speed"]["value"] = JSONObj["wind"]["speed"];
        weatherInfo["Pressure"]["value"] = JSONObj["main"]["pressure"];
        res.send(weatherInfo);
    });
  } catch(e) {
    console.log(e);
  }
});

app.get('/states', function(req, res) {
  res.send(statesJSON);
});

app.listen(7000, function() {
  console.log("Smarthome server active on localhost:7000");
});
