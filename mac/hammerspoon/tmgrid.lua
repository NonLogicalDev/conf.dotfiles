-- Grid Module
------------------------------------------------------------------------
local Grid = {}
Grid.__index = Grid
------------------------------------------------------------------------

local frames = nil

-- Module Methods
------------------------------------------------------------------------
function Grid.showGrid(grid, screens, action_fun) -- {{{
  local conf = {}
  local allScreens = screens
  if #allScreens >= 1 then
    local otherscreen = nil
    index = 1
    for i,screen in ipairs(allScreens) do
      table.insert(conf, { 
        ['screen'] = screen, ['prefix'] = index,
        ['grid'] = grid
      })
      index = index + 1
    end
  end

  return Grid.renderGrid(conf, action_fun)
end -- }}}
------------------------------------------------------------------------

-- Constructor Methods
------------------------------------------------------------------------
function Grid.renderGrid(init_grid, action_fun)  -- {{{
  local self = setmetatable({}, Grid)
  local maps = {}

  local prefixBindings = {}
  table.insert(prefixBindings, hs.hotkey.bind({}, "escape", function()
    self:kill()
  end))
  for i,map in ipairs(init_grid) do
    local tiles = _constructGrid(map.grid, map.prefix, map.screen, action_fun)
    self:genCtxBindings(prefixBindings,  map.prefix, tiles)

    maps[i] = {
      ['tiles'] = tiles
    }
  end

  self.maps = maps
  self.prefixBindings = prefixBindings
  self.active = true

  return self
end -- }}}
------------------------------------------------------------------------

-- Instance Methods
------------------------------------------------------------------------
function Grid.genCtxBindings(self, prefixBindings, prefix, tiles) -- {{{
  table.insert(prefixBindings, hs.hotkey.bind({}, ""..prefix, function()
    local ctxBindings = {}
    _deleteBindingList(self.ctxBindings)

    for ti,tile in ipairs(tiles) do
      table.insert(ctxBindings, hs.hotkey.bind({}, tile.hint, function()
        tile.fn()
        self:kill()
      end))
    end

    self.ctxBindings = ctxBindings
  end))
end -- }}}

function Grid.kill(self) -- {{{
  if not self.maps then
    return
  end

  for i,map in ipairs(self.maps) do
    for i,tile in ipairs(map.tiles) do
      _deleteRect(tile.frame)
    end
  end
  self.maps = nil
  self.active = false

  _deleteBindingList(self.prefixBindings)
  self.prefixBindings = {}

  _deleteBindingList(self.ctxBindings)
  self.ctxBindings = {}
end -- }}}
------------------------------------------------------------------------

-- Private Utility Functions
------------------------------------------------------------------------
function _constructGrid(hintrows, prefix, screen, action_fun) -- {{{
  grid = {}

  local rez_y = _len(hintrows)
  local rez_x = _len(hintrows[1])

  for i,row in ipairs(hintrows) do
    for j = 1, _len(row) do
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
      ['frame'] = _drawRect(hint, rect, 5),
      ['fn'] = function() 
        action_fun(rect, hint)
      end
      -- function()
      --   local w = hs.window.focusedWindow()
      --   w:setFrame(rect)
      -- end
    } 

    tiles[i] = tile
    i = i + 1
  end

  return tiles
end -- }}}

function _deleteBindingList(l) -- {{{
  print("-- clreaing out list")
  print(l)
  if l then
     print("-- deleting")
    for i,binding in ipairs(l) do
      binding:delete()
    end
  end
end -- }}}

function _len(t) -- {{{
  count = 0
  if type(t) == 'table' then
    for k,v in pairs(t) do
      count = count + 1
    end
  elseif type(t) == 'string' then
    count = string.len(t)
  end

  return count
end -- }}}

function _drawRect(text,rect,borderWidth) -- {{{
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

  local ts = 40
  local htf = {w=150,h=150}

  htf.x = f.x + f.w/2 - htf.w/2 
  htf.y = f.y + f.h/2 - htf.h/2


  -- Drawing frame
  local frame = hs.drawing.rectangle(rect)

  -- frame:setRoundedRectRadii(5.0, 5.0)
  frame:setStrokeWidth(borderWidth)
  frame:setStrokeColor(borderColor)
  frame:setFillColor(fillColor)
  frame:setStroke(true):setFill(true)

  frame:setLevel("floating")
  frame:show()

  -- Drawing text
  local text = hs.drawing.text(htf, text)
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
end -- }}}

function _deleteRect(rect) -- {{{
  rect.frame:delete()
  rect.text:delete()
end -- }}}
------------------------------------------------------------------------

return Grid
