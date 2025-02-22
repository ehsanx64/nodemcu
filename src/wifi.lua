-- Set mode to station
wifi.setmode(wifi.STATION)

-- Get current mode
print("! /wifi : current mode: " .. wifi.getmode())
print("! /wifi : connecting to " .. WIFI_SSID .. " ...")

-- Define a callback to display retrieved IP
function connected(params)
    print("! /wifi : IP: " .. params.IP)

    -- Start the telnet servr
    if TELNET_ENABLED then telnet:open() end
    
    -- Execute MQTT script
    if MQTT_ENABLED then dofile("mqtt.lua") end
    
end

-- Configure the station
station_cfg = {}
station_cfg.ssid = WIFI_SSID
station_cfg.pwd = WIFI_PASS
station_cfg.save = true
station_cfg.auto = true
station_cfg.got_ip_cb = connected
wifi.sta.config(station_cfg)

print("! /wifi : loaded")
