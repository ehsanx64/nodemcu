function heartbeat()
    local pingTimer = tmr.create()
    local interval = 6000
    
    local heartbeatTimer = tmr.create()
    local heartbeatInterval = 1000
    local heartbeatDone = false
    
    print()
    mqtt_publish("ping/status", "started")
    mqtt_publish("ping/heartbeat/status", "started")
    print("The ping timer will stop in (" .. (interval / 1000) .. ") seconds ...")

    pingTimer:register(interval, tmr.ALARM_SINGLE, function(t)
        heartbeatDone = true
        mqtt_publish("ping/status", "stopped")
        t:unregister()
    end)
    
    pingTimer:start()
    
    heartbeatTimer:register(heartbeatInterval, tmr.ALARM_AUTO, function(t)
        if heartbeatDone then
            mqtt_publish("ping/heartbeat/status", "stopped")
            t:unregister()
        else
            mqtt_publish("ping/heartbeat/tick", tmr.time())
        end
    end)
    
    heartbeatTimer:start()
end
