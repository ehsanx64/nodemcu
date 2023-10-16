-- Set mode to station
wifi.setmode(wifi.STATION)

-- Get current mode
print("Current WiFi mode: " .. wifi.getmode())

-- Define a callback to display retrieved IP
function connected(params)
    -- Execute MQTT script
    dofile("mqtt.lua")
    print("IP: " .. params.IP)
end

-- Configure the station
station_cfg = {}
station_cfg.ssid = WIFI_SSID
station_cfg.pwd = WIFI_PASS
station_cfg.save = false
station_cfg.auto = true
station_cfg.got_ip_cb = connected
wifi.sta.config(station_cfg)

print("wifi loaded")
