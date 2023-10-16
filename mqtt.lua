m = mqtt.Client(MQTT_CLIENT_ID, 120)

m:lwt("/lwt", "offline", 0, 0)

function publish_ip()
    m:publish("/node", wifi.sta.getip(), 0, 0, function(client)
        print("IP sent to /node")
    end)
end

function handle_led(msg)
    if msg == "on" then
        led_on()
    elseif msg == "off" then
        led_off()
    else
        print("undefined message: " .. msg)
    end
end

function handle_node(msg)
    if msg == "ip" then
        publish_ip()
    end
end

-- on publish message receive event
m:on("message", function(client, topic, data)
    if data ~= nil then
        print(topic .. " : " .. data)
        if topic == "/led" then
            handle_led(data)
        elseif topic == "/node" then
            handle_node(data)
        end        
    else
        print(topic)
    end
end)

m:connect(MQTT_HOST, 1883, false, 
    function(client)
        print("connected")
        -- Calling subscribe/publish only makes sense once the connection
        -- was successfully established. You can do that either here in the
        -- 'connect' callback or you need to otherwise make sure the
        -- connection was established (e.g. tracking connection status or in
        -- m:on("connect", function)).
        
        -- subscribe topic with qos = 0
        client:subscribe("/led", 0, function(client)
            print("Subscribed to /led")
        end)

        client:subscribe("/node", 0, function(client)
            print("Subscribed to /node")
        end)        
        
        -- publish a message with data = hello, QoS = 0, retain = 0
        client:publish("/node", "boot", 0, 0, function(client)
            print("sent")
        end)
    end,
    function(client, reason) print("Connection failed reason: " .. reason)
end)

function publish_loop()
    local my_timer = tmr.create()
    
    my_timer:register(3000, tmr.ALARM_AUTO, function()
        publish_ip()
    end)
    
    my_timer:start()
end

tmr.delay(10000)

--[[ Development Calls

publish_ip()
publish_loop()

]]--
