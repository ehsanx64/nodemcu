local m = mqtt.Client(MQTT_CLIENT_ID, 120)

--[[
-- Topic Structure

/positron/NODE/TOPIC

NODE    The iot board (MQTT client ID)
--]]

function getTopic(topicName)
    return "/positron/" .. MQTT_CLIENT_ID .. "/" .. topicName
end

function publish_ip()
    -- m:publish(getTopic("stats/ip"), wifi.sta.getip(), 0, 0, function() 
    --     print()
    -- end)
    m:publish(getTopic("stats/ip"), wifi.sta.getip(), 0, 0, nil)
end

function mqtt_publish(topicName, value)
    m:publish(getTopic(topicName), value, 0, 0, nil)
end

m:lwt(getTopic("lwt"), "offline", 0, 0)

function publish_stats()
    local root = "stats/"
    
    m:publish(getTopic(root .. "heap"), node.heap(), 0, 0, nil)
    m:publish(getTopic(root .. "time"), tmr.time(), 0, 0, nil)
    m:publish(getTopic(root .. "chipid"), node.chipid(), 0, 0, nil)
    m:publish(getTopic(root .. "flashsize"), node.flashsize(), 0, 0, nil)
    m:publish(getTopic(root .. "cpufreq"), node.getcpufreq(), 0, 0, nil)
end


function handle_node(msg)
    if msg == "ip" then
        publish_ip()
    end
end

function publish_loop()
    local my_timer = tmr.create()
    
    my_timer:register(3000, tmr.ALARM_AUTO, function()
        publish_ip()
        publish_stats()
    end)
    
    my_timer:start()
end

-- on publish message receive event
m:on("message", function(client, topic, data)
    if data ~= nil then
        print(topic .. " : " .. data)
    elseif topic == getTopic("node") then
        handle_node(data)
    else
        -- print()
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
        client:subscribe(getTopic("led"), 0, function(client)
            print("Subscribed to " .. getTopic("led"))
        end)

        client:subscribe(getTopic("boot"), 0, function(client)
            print("Subscribed to " .. getTopic("node"))
        end)        
        
        -- publish a message with data = string, QoS = 0, retain = 0
        msg = tmr.time()
        client:publish(getTopic("boot"), msg, 0, 0, function(client)
            -- print("sent")
        end)
        
        publish_loop()
        
        if pingInterface ~= nil and type(pingInterface) == "table" then
            if pingInterface.SetClient ~= nil then
                if type(pingInterface.SetClient) == "function" then
                    pingInterface.SetClient(client)
                end
            end
        end
    end,
    function(client, reason) print("Connection failed reason: " .. reason)
end)

tmr.delay(10000)

--[[-- Development Calls
publish_ip()
publish_loop()
--]]--
