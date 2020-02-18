local typeAssert = require "extra.TypeError"

return function(particleType, xPosition, yPosition, xSpeed, ySpeed, xAcceleration, yAcceleration)
    
    typeAssert('Particle', 'number', 1, particleType)
    typeAssert('Particle', 'number', 2, xPosition)
    typeAssert('Particle', 'number', 3, yPosition)

    return {
        particleType = particleType,
        xPosition = xPosition,
        yPosition = yPosition,
        xSpeed = xSpeed or 0,
        ySpeed = ySpeed or 0,
        xAcceleration = xAcceleration or 0,
        yAcceleration = yAcceleration or 0
    }

end