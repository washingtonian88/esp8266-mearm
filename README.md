# esp8266-mearm
Hobby project for controlling a MeArm 4 servo robot arm with an esp8266 via wireless internet. 
[Check out the video here](https://youtu.be/cxozutfJ0Xk)

## Parts
* [MeArm](http://www.mearm.com/)
* [esp8266 12-Q](http://www.microcenter.com/product/455955/ESP8266_Based_WiFI_Module_V2_-_FCC-CE) (most likely a rebranded 12-E) 
* [RoboRemoFree](http://www.roboremo.com/)
* Misc Electronics

## Description
The individual servos of the MeArm are connected to a 5V power and ground with the sense pins connected individually to GPIO's on the esp-12 through transistor gates. The esp-12 runs an alarm timer (details in servo2.lua) that generates a 30 Hz control pulse. By modulating the duty time of this control pulse I can control the servos between a fully rotated (3000us) and no-rotation (0us) state. The values of the duty time are read from a TCP server in a loop allowing individual control of each servo's position. The TCP server I am using is the [RoboRemoFree](http://www.roboremo.com/) app from the google play store. Currently I have the esp-12 connecting to my WiFi network which I found to be less cumbersome than having it act as an access point.

## Future Mods
* Add 3.3V regulator to circuit so that only 5V external supply is needed. 
* Figure out method to make arm more portable - try different WiFi modes. 

## External Resources / Inspiration
[RoboRemoFree](http://www.roboremo.com/)

[nodeMCU](http://nodemcu.com/index_en.html)
