local resources = require("src.resources")
local classic = require("src.game.modes.classic")

local arcade = setmetatable({}, {__index = classic})
arcade.custombehavior = false
arcade.__index = arcade

function arcade.new(world)
    local self = setmetatable(classic.new(world), arcade)

    self.conecolor = "trafficcone"

    return self
end

function arcade:increasespeed()
    self.world.placer.speed = math.min(self.world.placer.speed + 0.025, 2)
end

function arcade:getrandomconecolor()
    local conecolor = "trafficcone"
    local random = math.random() * 100
    
    if random > 23 and random < 46 then
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

    return conecolor
end

function arcade:addcone()
    local accuracy = self.world.placer:getaccuracy()
    local deltascore = math.floor((accuracy - 50) * 2)

    local message = {
        time = 1;
    }

    if deltascore < 20 then
        message.text = "Good!"
    elseif deltascore < 60 then 
        message.text = "Great!"
    elseif deltascore < 90 then
        message.text = "Nice!"
    elseif deltascore < 95 then
        message.text = "Outstanding!"
    elseif deltascore <= 100 then
        message.text = "Perfect!"
    end

    if self.conecolor == "goldcone" then
        deltascore = deltascore * 10
        message.gold = true
    end

    table.insert(self.world.messages, message)

    self.conecolor = self:getrandomconecolor()
    self.world.score = self.world.score + deltascore
    self.world.stack:addcone(self.world.placer.cone)
    self.world.placer:setcone(self.world:createcone(self.conecolor))
    self.world.placer.x = 0
end

function arcade:input()
    if self.world.placer.cone then
        local accuracy = self.world.placer:getaccuracy()

        if accuracy >= 50 then
            if self.conecolor == "redcone" then
                love.audio.play(resources.sounds.red)

                table.insert(self.world.messages, {
                    time = 1;
                    text = "Fail!";
                    red = true;
                })

                self.conecolor = self:getrandomconecolor()
                self.world.placer:setcone(self.world:createcone())
                self.world:flashcolor({1, 0, 0})

                -- remove 5 cones from the stack and remove 250 score
                for i = 1, 5 do 
                    self.world.stack:removecone()
                end

                if self.world.score >= 250 then
                    self.world.score = self.world.score - 250
                end
            else
                -- place cone
                if self.conecolor == "goldcone" then
                    love.audio.play(resources.sounds.gold)
                    self.world:flashcolor({1, 0.768, 0})
                end

                self:addcone()
                self:increasespeed()
                self.world:playconesound()
            end
        else
            if self.conecolor == "redcone" then
                love.audio.play(resources.sounds.conefall)

                self.conecolor = self:getrandomconecolor()
                self.world.placer:setcone(self.world:createcone(self.conecolor))
                self.world:flashcolor({0, 1, 0})
            else
                self.world:lose()
            end
        end
    end
end

return arcade
