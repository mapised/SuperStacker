local gui = require("src.gui")
local resources = require("src.resources")

local mainmenu = {}

function mainmenu.enter(menu)

    local play = gui:createbutton(0, 0, 220, 65, "center", "center")
    play.text = "Play!"
    play.onclick = function()
        menu:setmenu("playmenu")
    end

    --[[
    local leaderboard = gui:createbutton(0, 45, 220, 65, "center", "center")
    leaderboard.text = "Leaderboard"
    leaderboard.onclick = function()
        --menu:setmenu("leaderboard")
    end

    local options = gui:createbutton(0, 135, 220, 65, "center", "center")
    options.text = "Options"
    options.onclick = function()
        menu:setmenu("options")
    end
    ]]

end

function mainmenu.draw()
    gui:drawtext("Super Stacker 3D", 0, -200, resources.fonts.regular60px, "center", "center")
end

return mainmenu
