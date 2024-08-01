local upload = require "resty.upload"
local cjson = require "cjson"

local chunk_size = 4096
local form = upload:new(chunk_size)
local file_accepted = true

form:set_timeout(1000) -- 1 sec

while true do
    local typ, res, err = form:read()

    if not typ then
        ngx.say("Failed to read form: ", err)
        return
    end

    if typ == "header" then
        if res[1] == "Content-Disposition" then
            local filename = res[2]:match('filename="([^"]+)"')
            if filename then
                if filename:match("%.exe$") then
                    ngx.log(ngx.INFO, "Executable upload rejected: ", filename)
                    file_accepted = false
                    break
                end
            end
        end
    elseif typ == "eof" then
        break
    end
end

if file_accepted then
    ngx.say(cjson.encode({status = "success", message = "File uploaded successfully"}))
else
    ngx.status = ngx.HTTP_FORBIDDEN
    ngx.say(cjson.encode({status = "error", message = "Executable files are not allowed"}))
    ngx.exit(ngx.HTTP_FORBIDDEN)
end

-- ngx.log(ngx.ERR, "file_filter.lua is being executed")
-- return ngx.exit(403) -- For testing, block all requests
