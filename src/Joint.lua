local config = require "extra.Config"
local typeAssert = require "extra.TypeError"

function extractPointLocations(point)
    local x, y = point:match("^(%d+),(%d+)")
    return {tonumber(x), tonumber(y)}
end

local types = {"distance", "prismatic", "pulley", "revolute"}

function Joint(id, ground1, ground2, jointDef)
    
    typeAssert("Joint", "number", "ground1", ground1)
    typeAssert("Joint", "number", "ground2", ground2)
    typeAssert("Joint", "number", "jointDef.type", jointDef.type)
    assert(jointDef.type >= 0 and jointDef.type < 4, "Joint type should be between 0 and 3 (inclusive)")

    jointDef = setmetatable(jointDef or {}, config)
 
    local joint = {
        id = id,
        type = jointDef.type,
        typeWord = types[jointDef.type + 1],
        ground1 = ground1,
        ground2 = ground2,
        jointDef = jointDef,
        type = jointDef.type,
        point1 = jointDef.point1,
        frequency = jointDef.frequency,
        damping = jointDef.damping,
        limit1 = jointDef.limit1,
        limit2 = jointDef.limit2,
        forceMotor = jointDef.forceMotor,
        speedMotor = jointDef.speedMotor,
        ratio = jointDef.ratio,
        line = jointDef.line,
        color = jointDef.color,
        alpha = jointDef.alpha,
        foreground = jointDef.foreground, 
        visible = not not (jointDef.line or jointDef.color or jointDef.alpha)
    }
    
    local p1 = jointDef.point1 and extractPointLocations(jointDef.point1)
    joint.x1 = p1 and p1[1]
    joint.y1 = p1 and p1[2]
    if joint.type == 0 then -- set point2 for distance and pulley joints
        joint.point2 = jointDef.point2 
        local p2 = jointDef.point2 and extractPointLocations(jointDef.point2)
        joint.x2 = p2 and p2[1]
        joint.y2 = p2 and p2[2]
    elseif joint.type == 2 then -- setting point3 and point4 for pulley joints
        joint.point3 = jointDef.point3
        joint.point4 = jointDef.point4
        joint.point2 = jointDef.point2 
        local p2 = jointDef.point2 and extractPointLocations(jointDef.point2)
        local p3 = jointDef.point3 and extractPointLocations(jointDef.point3)
        local p4 = jointDef.point4 and extractPointLocations(jointDef.point4)
        joint.x2 = p2 and p2[1]
        joint.y2 = p2 and p2[2]
        joint.x3 = p3 and p3[1]
        joint.y3 = p3 and p3[2]
        joint.x4 = p4 and p4[1]
        joint.y4 = p4 and p4[2]
    elseif joint.type == 1 then -- setting axis and angle of prismatic joints
        joint.axis = jointDef.axis
        local axis = jointDef.axis and extractPointLocations(jointDef.axis)
        joint.axisX = axis[1]
        joint.axisY = axis[2]
    end

    return joint

end

return Joint
