local world = require("src.game.world")
local resources = require("src.resources")
local gui = require("src.gui")

local states = {
    mainmenu = require("src.menus.mainmenu");
    playmenu = require("src.menus.playmenu");
    options = require("src.menus.options");
}

local menu = {}

function menu:enter(oldScene, state)
    love.mouse.setVisible(true)
    self.background = world.new("static")

    if state then
        self:setmenu(state) 
    else
        self:setmenu("mainmenu")
    end
end

function menu:setmenu(state)
    gui:clear()

    if states[state] then
        self.state = states[state]
        self.state.enter(self)
    end
end

function menu:update(dt)
    self.background:update(dt)
end

function menu:draw()
    self.background:draw()

    gui:drawtext("A Cone Stacker fangame by Aiden", 10, 45, resources.fonts.regular20px, "left", "bottom")
    gui:drawtext("Cone Stacker is made by Gavin", 10, 0, resources.fonts.regular20px, "left", "bottom")

    if self.state then
        self.state:draw()
    end
end

function menu:keypressed(key)

end

function menu:exit()
    
end

return menu