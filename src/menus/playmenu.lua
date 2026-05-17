local mainmenu = require("src.menus.mainmenu")
local gui = require("src.gui")
local resources = require("src.resources")

local playmenu = {}

function playmenu.enter(menu)

    local classic = gui:createbutton(-160, -45, 240, 65, "center", "center")
    classic.text = "Classic"
    classic.onclick = function()
        require("src.scenes"):switch("game", "classic", 1)
    end

    local arcade = gui:createbutton(-160, 45, 240, 65, "center", "center")
    arcade.text = "Arcade"
    arcade.onclick = function()
        require("src.scenes"):switch("game", "arcade", 1)
    end

    local duels = gui:createbutton(-160, 135, 240, 65, "center", "center")
    duels.text = "Duels"
    duels.onclick = function()
        require("src.scenes"):switch("game", "arcade", 2)
    end

    local threeway = gui:createbutton(160, -45, 240, 65, "center", "center")
    threeway.text = "Truels"
    threeway.onclick = function()
        require("src.scenes"):switch("game", "arcade", 3)
    end

    local fourway = gui:createbutton(160, 45, 240, 65, "center", "center")
    fourway.text = "Fruels"
    fourway.onclick = function()
        require("src.scenes"):switch("game", "arcade", 4)
    end

    local royale = gui:createbutton(160, 135, 240, 65, "center", "center")
    royale.text = "Royale"
    royale.onclick = function()
        require("src.scenes"):switch("game", "arcade", 12)
    end

    local back = gui:createbutton(0, 225, 240, 65, "center", "center")
    back.text = "Back"
    back.onclick = function()
        menu:setmenu("mainmenu")
    end

end

function playmenu.draw()
    mainmenu.draw()

    gui:drawsprite(resources.sprites.classic, -160-80, -45, 1.5, 1.5, "center", "center", {1, 1, 1})
    gui:drawsprite(resources.sprites.arcade, -160-80, 45, 1.5, 1.5, "center", "center", {1, 1, 1})
    gui:drawsprite(resources.sprites.duels, -160-80, 135, 1.5, 1.5, "center", "center", {1, 1, 1})
    gui:drawsprite(resources.sprites.threeway, 160-80, -45, 1.5, 1.5, "center", "center", {1, 1, 1})
    gui:drawsprite(resources.sprites.fourway, 160-80, 45, 1.5, 1.5, "center", "center", {1, 1, 1})
    gui:drawsprite(resources.sprites.royale, 160-80, 135, 1.5, 1.5, "center", "center", {1, 1, 1})
end

return playmenu
