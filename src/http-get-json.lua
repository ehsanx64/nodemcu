local apiUrl = "http://10.42.0.1/json.php"
http.get(apiUrl, nil, function(code, data)
    if (code < 0) then
        print("HTTP request failed")
    else
        if code == 200 then
            local t = sjson.decode(data)
            data = t.data

            print('Command: ' .. t.command)
            print('System: ' .. t.uname)
            print('Time: ' .. t['time'])
            print('Date & Time: ' .. t['date_time'])

            if data == nil then
                print('no data')
                return
            end
            
            if type(data) == 'table' and #data > 0 then
                print('Data:')
                for k, v in pairs(data) do
                    print('ID: ' .. v.id .. ', Name: ' .. v.name)
                end
            else
                print('No data found')
            end
        end
    end
end)
