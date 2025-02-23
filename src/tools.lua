-- Dump the table given as t
function dumpTable(t)
    for k, v in pairs(t) do print(k .. " : " .. tostring(v)) end
end

-- List the modules that were compiled in firmware
function getModules()
    dump_table(getmetatable(_G)["__index"])
end

-- Display memory stats
function stats()
    print("Heap:   " .. node.heap())
    print("Size:   " .. node.flashsize())
    print("Uptime: " .. tmr.time())
end
--
-- List all files in the SPIFFS file system
function listFiles()
    for name, size in pairs(file.list()) do
        print("File: " .. name .. ", Size: " .. size .. " bytes")
    end
end
