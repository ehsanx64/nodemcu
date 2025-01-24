-- Dump the table given as t
function dump_table(t)
    for k, v in pairs(t) do
        print(k .. " : " .. tostring(v))
    end
end

-- List the modules that were compiled in firmware
function get_modules()
    dump_table(getmetatable(_G)["__index"])
end

-- Display memory stats
function stats()
    print("Heap Info: " .. node.heap())
    print("Flash Size: " .. node.flashsize())
end
