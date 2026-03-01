local vel = vector.new()
local arm = false
local tick = 0

while true do
    vel = ship.getVelocity()

    if vel:length() > 3 then tick = tick + 1 end
    if tick == 8 then arm = true end

    if arm and redstone.getAnalogInput('front') >= 13 then
        redstone.setOutput('back', true)
    end

    sleep(0.05)
end
