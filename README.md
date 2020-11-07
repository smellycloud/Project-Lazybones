# Project Lazybones

![](https://github.com/smellycloud/Project-Lazybones/blob/main/Mockups/1.jpeg?raw=true)


## Flutter application to control GPIO pins on a Raspberry Pi 3/4

Open the Frontend folder in Android Studio and run `pub get`
* Navigate to the networkhelper.dart file and change the IP address to your Raspberry Pi
* On the Raspberry Pi, open a terminal window and run `hostname -I` to get the IP address
* Connect your device and build



Transfer the contents of the Backend folder to a Raspberry Pi
* Ensure that the Raspberry Pi has a static IP address. If not, your router's DHCP server might keep changing the IP on every boot
* Run `npm install` to install all Node dependencies
* Open brain.js and change the pin numbers/device names/number of devices to your configuration. All changes will reflect automatically in the app
* Enter your own API key for OpenWeatherMap in brain.js
* Run `nodemon brain.js`



## To-do
* Add encryption to REST API
* Add Firebase authentication to the Flutter application
* Create Settings page
* Build diagnostics tool
* Add scheduling 
