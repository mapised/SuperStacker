local lldebugger = require("lldebugger")

if arg[2] == "debug" then
    lldebugger.start()
end

local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end