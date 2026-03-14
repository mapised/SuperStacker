local button = {}
button.__index = button

function button.new(x, y, w, h)
    local self = {}
    setmetatable(self, button)

    self.x = 0

    return self
end

return button