-- on a collision, da/dt is extremely high
-- so we use this to detect collision
-- which is better than using distance sensors

local math = require "math"

local rs = peripheral.wrap('right')

local THRESHOLD = tonumber(arg[1]) or 18
local arm_countdown = 60

-- prev, current
local vel = {0, 0}
local accel = {0, 0}
local jerk = 0

local function detonate()
    rs.setOutput('back', true)
    rs.setOutput('top', true)
    rs.setOutput('bottom', true)
    rs.setOutput('left', true)
    rs.setOutput('right', true)
end

while true do
    vel[2] = ship.getVelocity():length()
    accel[2] = vel[2] - vel[1]
    jerk = math.abs(accel[2] - accel[1])

    vel[1] = vel[2]
    accel[1] = accel[2]

    if jerk > THRESHOLD and arm_countdown <= 0 then
        detonate()
    end
    if redstone.getInput('left') and vel[2] > 10 then
        arm_countdown = arm_countdown - 1
    end

    sleep(0.05)
end
