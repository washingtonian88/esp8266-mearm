wifi.setmode(wifi.STATION)
wifi.sta.config("SSID","PASSWORD") 

port = 9876

function stringStarts(a,b)
    return string.sub(a,1,string.len(b))==b
end

function stringEnds(a,b)
   return b=='' or string.sub(a,-string.len(b))==b
end

servo1 = {}
servo1.pin = 7 --this is GPIO13
servo1.value = 1500
servo1.id = "servo1"

servo2 = {}
servo2.pin = 6 --this is GPIO12
servo2.value = 1500
servo2.id = "servo2"

servo3 = {}
servo3.pin = 5 --this is GPIO14
servo3.value = 1500
servo3.id = "servo3"

servo4 = {}
servo4.pin = 4 --this is GPIO2
servo4.value = 1500
servo4.id = "servo4"


cmd = ""

gpio.mode(servo1.pin,gpio.OUTPUT)
gpio.write(servo1.pin,gpio.LOW)
gpio.mode(servo2.pin,gpio.OUTPUT)
gpio.write(servo2.pin,gpio.LOW)
gpio.mode(servo3.pin,gpio.OUTPUT)
gpio.write(servo3.pin,gpio.LOW)
gpio.mode(servo4.pin,gpio.OUTPUT)
gpio.write(servo4.pin,gpio.LOW)

tmr.alarm(1,30,1,function() -- 33Hz 
    if servo1.value then -- generate pulse
        gpio.write(servo1.pin, gpio.HIGH)
        tmr.delay(servo1.value)
        gpio.write(servo1.pin, gpio.LOW)
    end
end)

tmr.alarm(2,30,1,function() -- 33Hz 
    if servo2.value then -- generate pulse
        gpio.write(servo2.pin, gpio.HIGH)
        tmr.delay(servo2.value)
        gpio.write(servo2.pin, gpio.LOW)
    end
end)

tmr.alarm(3,30,1,function() -- 33Hz 
    if servo3.value then -- generate pulse
        gpio.write(servo3.pin, gpio.HIGH)
        tmr.delay(servo3.value)
        gpio.write(servo3.pin, gpio.LOW)
    end
end)

tmr.alarm(4,30,1,function() -- 33Hz 
    if servo4.value then -- generate pulse
        gpio.write(servo4.pin, gpio.HIGH)
        tmr.delay(servo4.value)
        gpio.write(servo4.pin, gpio.LOW)
    end
end)
    

function exeCmd(st) -- example: "servo 1500"
    if stringStarts(st, servo1.id.." ") then -- value comes after id + space
        servo1.value = tonumber( string.sub(st,1+string.len(servo1.id.." "),string.len(st)) )
    end
    
    if stringStarts(st, servo2.id.." ") then -- value comes after id + space
        servo2.value = tonumber( string.sub(st,1+string.len(servo2.id.." "),string.len(st)) )
    end
    
    if stringStarts(st, servo3.id.." ") then -- value comes after id + space
        servo3.value = tonumber( string.sub(st,1+string.len(servo3.id.." "),string.len(st)) )
    end
    
    if stringStarts(st, servo4.id.." ") then -- value comes after id + space
        servo4.value = tonumber( string.sub(st,1+string.len(servo4.id.." "),string.len(st)) )
    end
end


function receiveData(conn, data)
    cmd = cmd .. data

    local a, b = string.find(cmd, "\n", 1, true)   
    while a do
        exeCmd( string.sub(cmd, 1, a-1) )
        cmd = string.sub(cmd, a+1, string.len(cmd))
        a, b = string.find(cmd, "\n", 1, true)
    end 
end


srv=net.createServer(net.TCP) 
srv:listen(port,function(conn)
    print("RoboRemo connected")
    conn:send("dbg connected ok\n")
     
    conn:on("receive",receiveData)  

    conn:on("disconnection",function(c) 
        print("RoboRemo disconnected")
    end)
    
end)

ip, nm, gw =wifi.sta.getip()
print("\nIP Info:\nIP Address: "..ip.." \nNetmask: "..nm.." \nGateway Addr: "..gw.."\n")
