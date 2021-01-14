-- title:  Escape from shadows
-- author: Felipe Marques Stefani
-- desc:   Learning Lua (2D Action RPG)
-- script: lua
player = {
  sprite = 32, -- player's sprite
  x = 120, -- position x
  y = 68 -- position y
}

consts = {
  screenWidth = 30,
  screenHeight = 17
}

function collidesWithMap(point)
  blockX = point.x / 8
  blockY = point.y / 8
  blockId = mget(blockX, blockY)
  if blockId >= 128 then
    return true
  else
    return false
  end
end

function tryToMoveTo(myDisplacementX, myDisplacementY)
  superiorLeft = {
    x = player.x - 8 + myDisplacementX,
    y = player.y - 8 - 1
  }
  superiorRight = {
    x = player.x + 7 + myDisplacementX,
    y = player.y - 8 + myDisplacementY
  }
  inferiorRight = {
    x = player.x + 7 + myDisplacementX,
    y = player.y + 7 + myDisplacementY
  }
  inferiorLeft = {
    x = player.x - 8 + myDisplacementX,
    y = player.y + 7 + myDisplacementY
  }
  if collidesWithMap(inferiorRight) or collidesWithMap(inferiorLeft) or collidesWithMap(superiorRight) or
    collidesWithMap(superiorRight) then
  else
    player.y = player.y + myDisplacementY
    player.x = player.x + myDisplacementX
  end
end

function update()
  -- up
  if btn(0) then
    tryToMoveTo(0, -1)
  end
  -- down
  if btn(1) then
    tryToMoveTo(0, 1)
  end
  -- left
  if btn(2) then
    tryToMoveTo(-1, 0)
  end
  -- right
  if btn(3) then
   tryToMoveTo(1, 0)
  end
end

function drawMap()
  map(0, -- position x in the map
  0, -- position y in the map
  consts.screenWidth, consts.screenHeight, 0, -- in which point x will be set
  0) -- in which point y will be set
end

function drawPlayer()
  spr(player.sprite, player.x - 8, player.y - 8, 0, -- background color
  1, -- scale
  0, -- mirror
  0, -- rotate
  2, -- quantity of blocks to the right
  2) -- quantity of blocks to the left
end

function draw()
  cls()
  drawMap()
  drawPlayer()
end

function TIC()
  update()
  draw()
end
