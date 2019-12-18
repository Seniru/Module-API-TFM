local Object = {}
Object.id = 0

function Object.new(type, x, y, angle, vx, vy, ghost, colors)
    Object.id = Object.id + 1
    colors = colors or {}
    return {
        angle = angle,
        baseType = type,
        colors = colors,
        ghost = ghost,
        id = Object.id,
        type = type,
        vx = vx,
        vy = vy,
        x = x,
        y = y,
        ghost = ghost
    }
end

return Object.new
