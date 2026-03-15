local mainmenu = require("src.menus.mainmenu")
local gui = require("src.gui")
local resources = require("src.resources")

local playmenu = {}

function playmenu.enter(menu)
    local classic = gui:createbutton(0, -45, 220, 65, "center", "center")
    classic.text = "Classic"
    classic.onclick = function()
        require("src.scenes"):switch("game", "classic", 1)
    end

    local arcade = gui:createbutton(0, 45, 220, 65, "center", "center")
    arcade.text = "Arcade"
    arcade.onclick = function()
        require("src.scenes"):switch("game", "arcade", 1)
    end

    local duels = gui:createbutton(0, 135, 220, 65, "center", "center")
    duels.text = "Duels"
    duels.onclick = function()
        require("src.scenes"):switch("game", "arcade", 2)
    end

    local back = gui:createbutton(0, 225, 220, 65, "center", "center")
    back.text = "Back"
    back.onclick = function()
        menu:setmenu("mainmenu")
    end
end

function playmenu.draw()
    mainmenu.draw()

    gui:drawsprite(resources.sprites.classic, -75, -45, 1.5, 1.5, "center", "center", {1, 1, 1})
    gui:drawsprite(resources.sprites.arcade, -75, 45, 1.5, 1.5, "center", "center", {1, 1, 1})
    gui:drawsprite(resources.sprites.duels, -75, 135, 1.5, 1.5, "center", "center", {1, 1, 1})
end

return playmenu
