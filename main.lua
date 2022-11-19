-- [[to run application /Applications/love.app/Contents/MacOS/love .]]
function love.load()
    target = {}
    target.x = 200
    target.y = 300
    target.radius = 50

    gameScreen = 1

    timer = 0

    score = 0
    scoreFont = love.graphics.newFont(40)

    upperTextHeight = 20

    sprites = {}
    sprites.sky = love.graphics.newImage("sprites/sky.png")
    sprites.crosshairs = love.graphics.newImage("sprites/crosshairs.png")
    sprites.target = love.graphics.newImage("sprites/target.png")

    love.mouse.setVisible(false)
end

function love.update(dt)
    if timer > 0 then
        timer = timer - dt
    end

    if timer < 0 then
        timer = 0
        gameScreen = 1
    end

end

function love.draw()
    -- love.graphics.setColor(1,0.4,0.5)
    -- love.graphics.circle("fill", target.x, target.y, target.radius)

    love.graphics.draw(sprites.sky, 0, 0)

    love.graphics.setColor(1,1,1)
    love.graphics.setFont(scoreFont)
    love.graphics.print("Score: " .. score, 0, 5)

    love.graphics.print("Timer: " .. math.ceil(timer), 250, 5)
    
    local crossHairOffset = 20;

    if gameScreen == 1 then
        love.graphics.printf("Click Anywhere to start!", 0, 250, love.graphics.getWidth(), "center")
    end

    if gameScreen == 2 then
        love.graphics.draw(sprites.target, target.x - target.radius, target.y - target.radius)
    end
    love.graphics.draw(sprites.crosshairs, love.mouse.getX() - crossHairOffset, love.mouse.getY() - crossHairOffset)

end


function love.mousepressed(x, y, button, istouch, presses)
    if gameScreen == 2 then
        local distanceOfTarget = distanceBetweenTargetAndMouse(x, y, target.x, target.y)
        if distanceOfTarget < target.radius then
            if button == 1 then
                score = score + 1
            end
            if button == 2 then
                score = score + 2
                timer = timer - 1
            end
            target.x = math.random(target.radius, love.graphics.getWidth() - target.radius)
            target.y = math.random(target.radius + upperTextHeight, love.graphics.getHeight() - target.radius)
        elseif score > 0 then
            score = score - 1
        end
    elseif button == 1 and gameScreen == 1 then
        gameScreen = 2
        score = 0
        timer = 10
    end
end

function distanceBetweenTargetAndMouse(x1, y1, x2, y2)
    return math.sqrt((x1 - x2)^2 + (y1-y2)^2)
end
