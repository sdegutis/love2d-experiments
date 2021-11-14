local dots = {}

local function addDot()
  local angle = love.math.random()*math.pi*2
  table.insert(dots, {
    angle=angle,
    distance=100,
  })
end

local function drawDot(dot)  
  local x = math.cos(dot.angle) * dot.distance
  local y = math.sin(dot.angle) * dot.distance

  love.graphics.setColor(0, 1, 1, 0.5)
  love.graphics.circle('fill', dot.x+x, dot.y+y, 5)
end

local function updateDot(dot)
  dot.x, dot.y = love.mouse.getPosition()
  dot.angle = dot.angle + .1
  if dot.angle >= math.pi*2 then dot.angle = 0 end
end

function love.load()
end

function love.draw()
  love.graphics.clear()
  for i, dot in ipairs(dots) do drawDot(dot) end
end

function love.update()
  if #dots == 0 then addDot() end
  for i, dot in ipairs(dots) do updateDot(dot) end
end
