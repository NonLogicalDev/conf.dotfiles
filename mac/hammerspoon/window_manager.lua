prefix = require("prefix")
tmgrid = require("tmgrid")

hs.hotkey.bind({'ctrl', 'alt'}, "\\", function() 
  hs.hints.style = 'vimperator'
  hs.hints.windowHints(nil, function(selWin) 
    selWin:focus()
  end)
end)

prefix.bind('', "h", function() 
  local win = hs.window.focusedWindow()
  if win == nil then return end
  win:focusWindowWest()
end)

prefix.bind('', "l", function() 
  local win = hs.window.focusedWindow()
  if win == nil then return end
  win:focusWindowEast()
end)

prefix.bind('', "j", function() 
  local win = hs.window.focusedWindow()
  if win == nil then return end
  win:focusWindowSouth()
end)

prefix.bind('', "k", function() 
  local win = hs.window.focusedWindow()
  if win == nil then return end
  win:focusWindowNorth()
end)

function showGridAllScreens(grid)
  local conf = {}
  local allScreens = hs.screen.allScreens()
  if #allScreens > 1 then
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

  return tmgrid.renderGrid(conf)
end

prefix.bind('', "g", function() 
  showGridAllScreens( {
    "aab",
    "aab",
    "aac"
  })
end)

prefix.bind('', "f", function() 
  showGridAllScreens( {
    "aaabbbbbcccc",
  })
end)


-- border = nil
-- prevWindow = nil
--
-- excludedApps = {
--   "Alfred 3",
--   "Bartender 2",
--   "1Password mini"
-- }
--
-- function drawBorder()
--   if border then
--     border:delete()
--   end
--
--   local win = hs.window.focusedWindow()
--   if win == nil then return end
--
--   local winAppName = win:application():name()
--   if utils.has_value(excludedApps, winAppName) then
--     return
--   end
--
--   local s = 10
--   local f = win:frame()
--   local fx = f.x -- - s/2
--   local fy = f.y -- - s/2
--   local fw = f.w -- + s
--   local fh = f.h -- + s
--
--   border = hs.drawing.rectangle(hs.geometry.rect(fx, fy, fw, fh))
--   border:setStrokeWidth(s)
--   border:setStrokeColor({["red"]=0.75,["blue"]=0.0,["green"]=0.0,["alpha"]=0.80})
--   border:setFillColor({["red"]=0.75,["blue"]=0.0,["green"]=0.0,["alpha"]=0.05})
--   border:setRoundedRectRadii(5.0, 5.0)
--   border:setStroke(true):setFill(false)
--   border:setLevel("floating")
--   border:show()
--
--   prevWindow = win
-- end
--
-- drawBorder()
--
-- windows = hs.window.filter.new(nil)
-- windows:subscribe(hs.window.filter.windowFocused, function () drawBorder() end)
-- windows:subscribe(hs.window.filter.windowUnfocused, function () drawBorder() end)
-- windows:subscribe(hs.window.filter.windowMoved, function () drawBorder() end)

-- This is a catch all case just in case
-- hs.timer.new(0.5, function() drawBorder() end):start()
