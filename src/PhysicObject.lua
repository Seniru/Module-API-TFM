local config = require 'src.Config'

function PhysicObject(id, x, y, bodyDef)

    assert(type(bodyDef.type) == 'number', 'Expected a number for type, instead got ' .. type(bodyDef.type))

    bodyDef = setmetatable(bodyDef or {}, config)
    return {
        id = id,
        xPosition = x,
        yPosition = y,
        type = bodyDef.type,
        width = bodyDef.width or 0,
        height = bodyDef.height or 0,
        foreground = not not bodyDef.foreground,
        friction = bodyDef.friction or 0,
        restitution = bodyDef.restitution or 0,
        ange = bodyDef.angle or 0,
        color = bodyDef.color,
        miceCollision = bodyDef.miceCollision == nil and true or bodyDef.miceCollision,
        groundCollision = bodyDef.groundCollision == nil and true or bodyDef.groundCollision,
        dynamic = not not bodyDef.dynamic,
        fixedRotation = not not bodyDef.fixedRotation,
        mass = bodyDef.mass or 0,
        linearDamping = bodyDef.linearDamping or 0,
        angularDamping = bodyDef.angularDamping or 0
    }

end

return PhysicObject
