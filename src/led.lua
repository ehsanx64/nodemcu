-- On Wemos D1 Mini the onboard LED is accessible through pin 4
LED = 4

-- Set the LED pin to output
gpio.mode(LED, gpio.OUTPUT)

-- Turn the LED on
function led_on()
    gpio.write(LED, gpio.LOW)
end

-- Turn the LED off
function led_off()
    gpio.write(LED, gpio.HIGH)
end

-- Display LED status
function led_print()
    local val = gpio.read(LED)
    local state = "N\\A";

    if val == gpio.LOW then 
        state = "On"
    elseif val == gpio.HIGH then
        state = "Off"
    end
    
    print("PIN4: " .. val)
    print("LED: " .. state)    
end

--[[ Usage

led_print()
led_on()
led_off()

]]--

print("! /led : loaded")