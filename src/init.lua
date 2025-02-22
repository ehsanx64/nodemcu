-- init.lua
print("! Running init ...")

-- Include main config file
dofile("config.lua")

-- Include project config file
for k, v in pairs(file.list()) do
    if k == PROJECT_FILE and v > 80 then dofile(PROJECT_FILE) break end
end

-- Include assets
if WIFI_ENABLED then dofile("wifi.lua") end
if TELNET_ENABLED then telnet = dofile("telnet.lua") end

dofile("led.lua")

-- We are done
print("! init done")






