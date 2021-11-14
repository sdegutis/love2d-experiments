local dots = {}

local function addDot()
  local angle = love.math.random()*math.pi*2
  table.insert(dots, {
    angle=angle,
    distance=love.math.random(60, 100),
    seconds=0,
    duration=0.4,
  })
end

local function drawDot(dot)
  local percent = dot.seconds / dot.duration
  local distance = dot.distance - (dot.distance * percent)

  local x = math.cos(dot.angle) * distance
  local y = math.sin(dot.angle) * distance

  love.graphics.setColor(0, 1, 1, 0.5 * (1-percent) + 0.05)
  love.graphics.circle('fill', dot.x+x, dot.y+y, 5)
end

local function del(t, el)
  for i = 1, #t do
    if t[i] == el then
      table.remove(t, i)
      return
    end
  end
end

local function updateDot(dot)
  dot.x, dot.y = love.mouse.getPosition()
  dot.seconds = dot.seconds + love.timer.getDelta()
  if dot.seconds >= dot.duration then
    del(dots, dot)
  end
end

function love.load()
end

function love.draw()
  love.graphics.clear()
  for i, dot in ipairs(dots) do drawDot(dot) end
end

local function makeRepeater(sec)
  local time = 0
  return function()
    time = time + love.timer.getDelta()
    if time >= sec then
      time = 0
      return true
    end
  end
end

local dotTimer = makeRepeater(0.1)

function love.update()
  if dotTimer() then
    for i = 1, 5 do addDot() end
  end
  for i, dot in ipairs(dots) do updateDot(dot) end
end
