local g3d = require("lib.g3d")
local timer = require("lib.timer")
local gui = require("src.gui")
local resources = require("src.resources")
local keybinds = require("src.keybinds")
local stack = require("src.game.stack")
local placer = require("src.game.placer")
local constants = require("src.constants")

local gamemodes = {
    static = require("src.game.modes.static");
    classic = require("src.game.modes.classic");
    arcade = require("src.game.modes.arcade");
}

local world = {}
world.__index = world

function world.new(mode, id, players)
    if gamemodes[mode] then
        local self = {}
        setmetatable(self, world)

        -- custom behavior?
        if not gamemodes[mode].custombehavior then
            self.stack = stack.new(self)
            self.placer = placer.new(self)
            self.stack:addcone()
        end

        self.id = id or 1
        self.players = players or 1
        self.score = 0
        self.backgroundcolor = constants.backgroundcolor
        self.messages = {}
        self.gameover = false
        self.mode = gamemodes[mode].new(self)

        return self
    end
end

function world:lose()
    self.gameover = true

    if self.mode.lose then
        self.mode:lose()
    end

    if self.players == 1 then
        -- create buttons
        love.mouse.setVisible(true)
        local playagain = gui:createbutton(0, 115, 220, 65, "center", "center")
        playagain.text = "Play Again"
        playagain.onclick = function()
            love.mouse.setVisible(false)
            self:reset()
        end

        local menu = gui:createbutton(0, 205, 220, 65, "center", "center")
        menu.text = "Main Menu"
        menu.onclick = function()
            require("src.scenes"):switch("menu")
        end
    end
end

function world:reset()
    if not self.mode.custombehavior then
        self.stack.length = 0
        self.stack.cones = {}
        self.stack:addcone()

        self.placer.x = 0
        self.placer.direction = -1
        self.placer.speed = 1
        self.placer.falling = false
        self.placer.fallspeed = 0
        self.placer:setcone(nil)
    end

    if self.mode.reset then
        self.mode:reset()
    end

    gui:clear()
    self.gameover = false
    
    self.mode.new(self)
end

function world:flashcolor(color)
    self.backgroundcolor = color
    
    timer.tween(0.5, {
        [self.backgroundcolor] = constants.backgroundcolor
    })
end

function world:createcone(color)
    local texture = resources.textures[color] or resources.textures.trafficcone
    local model = color == "redcone" and resources.models.redcone or resources.models.cone

    local cone = g3d.newModel(model, texture, {0, 0, 0}, {math.pi/2, 0, 0})
    cone:compress()

    return cone
end

function world:playconesound()
    resources.sounds.conedrop:setPitch(1 + ((math.random() - 0.5) * 0.2))

    love.audio.stop(resources.sounds.conedrop)
    love.audio.play(resources.sounds.conedrop)
end

function world:input()
    if not self.gameover then
        self.mode:input()
    end
end

function world:drawkeybinds()
    if keybinds[self.players] then
        local key = keybinds[self.players][self.id][1]
        if key then
            local sprite = resources.sprites.keys[key]
            if sprite then
                local y = 30
                if love.keyboard.isDown(key) then
                    y = y - 4
                end
                gui:drawsprite(sprite, 0, y, 3, 3, "center", "bottom")
            end
        end
    end
end

function world:drawmessages()
    for i, message in pairs(self.messages) do
        message.time = message.time - (love.timer.getDelta())

        if message.time <= 0 then
            self.messages[i] = nil
        else
            local r, g, b = 0, 0, 0
            if message.red then
                r, g, b = 1, 0, 0
            elseif message.gold then
                r, g, b = 0.827, 0.69, 0.21
            end
            gui:drawtext(message.text, 0, 80 + (message.time * 50), resources.fonts.regular40px, "center", "top", {r, g, b, message.time})
        end
    end
end

function world:draw()
    if not self.mode.custombehavior then
        self.stack:draw()
        self.placer:draw()
        self.mode:draw()
    end

    if self.duelsscore then
        local xallignment, yallignment = "right", "top"

        if self.id / 2 == math.floor(self.id / 2) then
            xallignment = "left"
        end

        if self.players >= 4 and self.id <= self.players / 2 then
            yallignment = "bottom"
        end

        gui:drawrectangle("line", 0, 0, 120, 120, xallignment, yallignment)
        gui:drawtextinsiderectangle(self.duelsscore, resources.fonts.regular40px, 0, 0, 120, 120, xallignment, yallignment)
    end

    if self.gameover then -- draw game over screen
        gui:drawtext("Game Over!", 0, -60, resources.fonts.regular40px, "center", "center")
        gui:drawtext("Score " .. self.score, 0, -10, resources.fonts.regular20px, "center", "center")
    else
        self:drawkeybinds()
    end

    self:drawmessages()
end

function world:update(dt)
    if not self.mode.custombehavior then
        self.placer:update(dt)
    end
    self.mode:update(dt)
end

return world