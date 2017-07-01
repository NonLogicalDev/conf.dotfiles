-- local drawing = require "hs.drawing"
-- local screen = require "hs.screen"
-- local window = require "hs.window"

function len(t)
  count = 0
  if type(t) == 'table' then
    for k,v in pairs(t) do
      count = count + 1
    end
  elseif type(t) == 'string' then
    count = string.len(t)
  end

  return count
end

function drawRect(text,rect,borderWidth)
  local borderColor = {
    ["red"]   = 1,
    ["blue"]  = 1,
    ["green"] = 1,
    ["alpha"] = 0.80
  }
  local fillColor = {
    ["red"]   = 0.0,
    ["blue"]  = 0.0,
    ["green"] = 0.0,
    ["alpha"] = 0.5
  }
  local textColor = {
    ["red"]   = 0.1,
    ["blue"]  = 0.1,
    ["green"] = 0.1,
    ["alpha"] = 1
  }

  local f = rect
  local s = borderWidth

  local fx = f.x - s/2
  local fy = f.y - s/2
  local fw = f.w + s
  local fh = f.h + s


  frame = hs.drawing.rectangle(rect)

  frame:setStrokeWidth(borderWidth)
  frame:setStrokeColor(borderColor)
  frame:setFillColor(fillColor)

  -- frame:setRoundedRectRadii(5.0, 5.0)

  frame:setStroke(true):setFill(true)

  frame:setLevel("floating")
  frame:show()

  local ts = 40
  local htf = {w=150,h=150}

  htf.x = f.x + f.w/2 - htf.w/2 
  htf.y = f.y + f.h/2 - htf.h/2
  

  text = hs.drawing.text(htf, text)
  text:setTextSize(ts)
  text:setTextFont('Lucida Grande')
  text:setTextStyle({
    ['alignment'] = 'center'
  })

  text:show()

  return {
    ['frame'] = frame,
    ['text'] = text
  }
end

function deleteRect(rect)
  rect.frame:delete()
  rect.text:delete()
end

function constructGrid(hintrows, prefix, screen)
  grid = {}

  local rez_y = len(hintrows)
  local rez_x = len(hintrows[1])

  for i,row in ipairs(hintrows) do
    for j = 1, len(row) do
      local char = string.sub(row, j, j)

      if grid[char] ==  nil then
        grid[char] = {
          ['x'] = j - 1,
          ['y'] = i - 1,
          ['w'] = 1,
          ['h'] = 1,
        }
      end

      local rect = grid[char]
      rect = {
        ['x'] = rect.x,
        ['y'] = rect.y,
        ['w'] = j - rect.x,
        ['h'] = i - rect.y,
      }
      grid[char] = rect
    end
  end

  local sframe = screen:frame()
  local rw = sframe.w / rez_x
  local rh = sframe.h / rez_y

  i = 1
  tiles = {}

  print("--------------------------")
  print(rez_x)
  print(rez_y)

  for key, val in pairs(grid) do
    local fx = sframe.x + val.x * rw
    local fy = sframe.y + val.y * rh
    local fw = val.w * rw
    local fh = val.h * rh

    print(key)

    local hint = ""..prefix..key
    local rect = hs.geometry.rect(fx,fy,fw,fh)
    tile = {
      ['hint'] = key,
      ['frame'] = drawRect(hint, rect, 5),
      ['fn'] = function()
        local w = hs.window.focusedWindow()
        w:setFrame(rect)
      end
    } 

    tiles[i] = tile
    i = i + 1
  end

  return tiles
end

local frames = nil

local Grid = {}
Grid.__index = Grid

function deleteBindingList(l)
  print("-- clreaing out list")
  print(l)
  if l then
     print("-- deleting")
    for i,binding in ipairs(l) do
      binding:delete()
    end
  end
end

function Grid.renderGrid(init_grid) 
  local self = setmetatable({}, Grid)
  local maps = {}

  local prefixBindings = {}
  table.insert(prefixBindings, hs.hotkey.bind({}, "escape", function()
    self:kill()
  end))
  for i,map in ipairs(init_grid) do
    local tiles = constructGrid(map.grid, map.prefix, map.screen)
    self:genCtxBindings(prefixBindings,  map.prefix, tiles)

    maps[i] = {
      ['tiles'] = tiles
    }
  end

  self.maps = maps
  self.prefixBindings = prefixBindings
  return self
end


function Grid.genCtxBindings(self, prefixBindings, prefix, tiles)
  table.insert(prefixBindings, hs.hotkey.bind({}, ""..prefix, function()
    local ctxBindings = {}
    deleteBindingList(self.ctxBindings)

    for ti,tile in ipairs(tiles) do
      table.insert(ctxBindings, hs.hotkey.bind({}, tile.hint, function()
        tile.fn()
        self:kill()
      end))
    end

    self.ctxBindings = ctxBindings
  end))
end

function Grid.kill(self)
  if not self.maps then
    return
  end

  for i,map in ipairs(self.maps) do
    for i,tile in ipairs(map.tiles) do
      deleteRect(tile.frame)
    end
  end
  self.maps = nil

  deleteBindingList(self.prefixBindings)
  self.prefixBindings = {}
  deleteBindingList(self.ctxBindings)
  self.ctxBindings = {}
end

return Grid
