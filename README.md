# Project Lazybones

![](https://github.com/smellycloud/Project-Lazybones/blob/main/Mockups/1.jpeg?raw=true)
![](https://github.com/smellycloud/Project-Lazybones/blob/main/Mockups/2.jpeg?raw=true)
![](https://github.com/smellycloud/Project-Lazybones/blob/main/Mockups/3.jpeg?raw=true)
![](https://github.com/smellycloud/Project-Lazybones/blob/main/Mockups/4.jpeg?raw=true)


## Flutter application to control GPIO pins on a Raspberry Pi 3/4

#### Step 1 : Open the Frontend folder in Android Studio and run "pub get"
#### Step 1.1 : Navigate to the networkhelper.dart file and change the IP address to your Raspberry Pi
#### Step 1.2 : On the Raspberry Pi, open a terminal window and run "hostname -I" to get the IP address
#### Step 1.3 : Connect your device and build



#### Step 2 : Transfer the contents of the Backend folder to a Raspberry Pi
#### Step 2.1 : Ensure that the Raspberry Pi has a static IP address. If not, your router's DHCP server might keep changing the IP on every boot
#### Step 2.2 : Run "npm install" to install all Node dependencies
#### Step 2.3 : Open brain.js and change the pin numbers/device names/number of devices to your configuration. All changes will reflect automatically in the app
#### Step 2.3 : Enter your own API key for OpenWeatherMap in brain.js
#### Step 2.4 : Run "nodemon brain.js"



## To-do
#### Add encryption to REST API
#### Add Firebase authentication to the Flutter application
#### Create Settings page
#### Build diagnostics tool

