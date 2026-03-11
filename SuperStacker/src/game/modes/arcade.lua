local constants = require("src.constants")
local classic = require("src.game.modes.classic")

local arcade = setmetatable({}, {__index = classic})
arcade.custombehavior = false
arcade.__index = arcade


function arcade.new(world)
    local self = setmetatable(classic.new(world), arcade)

    self.conecolor = "trafficcone"

    return self
end

function arcade:addcone()
    self.conecolor = self:getrandomconecolor()

    self.world.stack:addcone(self.world.placer.cone)
    self.world.placer:setcone(self.world:createcone())
    self.world.placer.x = 0

    local deltaScore = math.floor((constants.placerX - math.abs(self.world.placer.x)) * 50)

    if deltaScore < 20 then
        --self.world:addmessage("Good!")
    elseif deltaScore < 60 then 
        --self.world:addmessage("Great!")
    elseif deltaScore < 90 then
        --self.world:addmessage("Nice!")
    elseif deltaScore < 95 then
        --self.world:addmessage("Outstanding!")
    elseif deltaScore <= 100 then
        --self.world:addmessage("Perfect!")
    end

    self.world.score = self.world.score + deltaScore
end

function arcade:dropcone()
    if self.world.placer.cone then
        local accuracy = self.world.placer:getaccuracy()

        if accuracy >= 50 then
            if self.conecolor == "redcone" then
                self.conecolor = self:getrandomconecolor()
                self.world.placer:setcone(self.world:createcone())
            else
                -- place cone
                self:addcone()
                self:playconesound()
                self:increasespeed()
            end
        else
            self.world:lose()
        end
    end
end

function arcade:getrandomconecolor()
    local conecolor = "trafficcone"
    local random = math.random() * 100
    
    if random < 23 then
        conecolor = "trafficcone"
    elseif random < 46 then
        conecolor = "yellowcone"
    elseif random < 69 then
        conecolor = "orangecone"
    elseif random < 92 then
        conecolor = "bluecone"
    elseif random < 96 then
        conecolor = "goldcone"
    else
        conecolor = "redcone"
    end

    return conecolor;
end


return arcade
