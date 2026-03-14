local timer = require("lib.timer")

local scenes = {
    scenes = {
        game = require("src.scenes.game");
        menu = require("src.scenes.menu");
    }
}

function scenes:load()
    self.scene = self.scenes.menu
    self.scene:enter()
end

function scenes:switch(newScene, ...)
    local oldScene = tostring(self.scene)
    if oldScene ~= newScene then
        timer.clear()
        
        self.scene:exit()
        self.scene = self.scenes[newScene]
        if self.scene then
            self.scene:enter(oldScene, ...)
        end
    end
end

function scenes:call(event, ...)
    if self.scene[event] then
        self.scene[event](self.scene, ...)
    end
end
    
return scenes