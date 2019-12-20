local typeAssert = require 'extra.TypeError'

return function(xPosition, yPosition, duration)

    typeAssert('Conjuration', 'number', 1, xPosition)
    typeAssert('Conjuration', 'number', 2, yPosition)
    typeAssert('Conjuration', {'number', 'nil'}, 3, duration)

    return {
        xPosition = xPosition,
        yPosition = yPosition,
        duration = duration or 10000
    } 
end
