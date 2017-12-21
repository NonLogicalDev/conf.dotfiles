local utils = require("utils")
local prefix = require("prefix")
local tmgrid = require("tmgrid")
local qa = require("menubar")


------------------------------------------------------------------------
--                            Helper Utils                            --
------------------------------------------------------------------------

function langSwitch(code) -- {{{
  return function()
    if code == "EN" then
      hs.keycodes.setLayout("U.S.")
    elseif code == "RU" then
      hs.keycodes.setLayout("Russian - Phonetic")
    end
  end
end -- }}}

local ggrid = nil
local windowYankBuffer = nil
local windowMap = {}

function bindGrid(key, grid, screens) -- {{{
  local uGrid = {}
  for k,v in pairs(grid) do
    uGrid[k] = string.reverse(v)
  end

  local winSizeFun = function(rect, hint)
    local w = hs.window.focusedWindow()
    windowMap[w:id()] = rect
    w:setFrame(rect)
  end

  prefix.bind('', key, function() 
    if not(ggrid and ggrid.active == true) then
      ggrid = tmgrid.showGrid(grid, hs.screen.allScreens(), winSizeFun)
    end
  end)

  prefix.bind('shift', key, function() 
    if not(ggrid and ggrid.active == true) then
      ggrid = tmgrid.showGrid(uGrid, hs.screen.allScreens(), winSizeFun)
    end
  end)
end -- }}}

function winSelect() -- {{{
  -- hs.hints.style = 'vimperator'
  hs.hints.windowHints(nil, function(selWin) 
    selWin:focus()
  end)
end -- }}}

function windowYank() -- {{{
  local w = hs.window.focusedWindow()

  windowYankBuffer = {}
  windowYankBuffer['win_id'] = w:id()

  print(windowYankBuffer['win_id'])
end -- }}}

function windowPut() -- {{{
  if not(windowYankBuffer) then
    print("Window Buffer not set")
    return 
  end
  local win_id = windowYankBuffer['win_id']
  print(windowYankBuffer['win_id'])

  local w = hs.window.find(win_id)
  if not(w) then 
    print("No window with id")
    return
  end

  local cur_screen = hs.screen.mainScreen()
  local scs = hs.screen.allScreens()

  tmgrid.showGrid({'.'}, scs, function(rect, hint) 
    local screen_num = tonumber(string.sub(hint, 0, 1))
    w:moveToScreen(scs[screen_num])
  end)

end -- }}}
------------------------------------------------------------------------
--                           Configuration                            --
------------------------------------------------------------------------

-- Global Mappings

prefix.bind('', '`', hs.toggleConsole)
prefix.bind('', '\\', hs.reload)

prefix.bind('', 'y', windowYank)
prefix.bind('', 'p', windowPut)

-- Language Manager

prefix.bind({}, 'n', function() 
  langSwitch("EN")()
end)

prefix.bind({}, 'm', function() 
  langSwitch("RU")()
end)

-- Window Manager

bindGrid("q", {
  "abc",
  "abc",
})

bindGrid("w", {
  "aaaabbbbbccc",
})

bindGrid("e", {
  "bbbbbaaa",
  "bbbbbaaa",
  "bbbbbccc", 
})

bindGrid("r", {
  "aaaaabbb",
})

bindGrid("t", {
  "bbbbbaaa",
  "bbbbbaaa",
  "bbbbbaaa",
  "bbbbbccc", 
  "bbbbbccc", 
})

bindGrid("y", {
  "aaaaaaabbb",
})

hs.hotkey.bind({'ctrl', 'alt'}, "\\", function() 
  winSelect()
end)

prefix.bind({'shift'}, "/", function() 
  local w = hs.window.focusedWindow()
  rect = windowMap[w:id()]
  if rect == nil then
    print("Window lacks rect info")
  else
    w:setFrame(rect)
  end
end)

-- bindGrid("g", {
--   "aab",
--   "aab",
--   "aac"
-- })

------------------------------------------------------------------------
--                               Unused                               --
------------------------------------------------------------------------

-- qa.setMenu({
--   qa.mkmenu("Languages", {
--     qa.mkmenu("English", langSwitch("EN")),
--     qa.mkmenu("Russian", langSwitch("RU")),
--   }),
--   qa.mkmenu("-"),
--   qa.mkmenu("Exit")
-- }).update()
--
-- prefix.bind({}, 'q', function() 
--   local p = hs.screen.mainScreen():frame().center
--   qa.bar:popupMenu(p)
-- end)

-- qa = {}
-- qa.menu = {
--   { title = "Work Utils", 
--     menu = {
--       { title = "Mail GenStatus (This Week)", fn = function () workUtil_GenStatus(1) end },
--       { title = "Mail GenStatus (Past Week)", fn = function () workUtil_GenStatus(0) end }
--     }
--   },
-- }
--
-- qa.bar = hs.menubar.new()
-- qa.bar:setTitle("QAct")
-- qa.bar:setMenu(qa.menu)
--
-- function workUtil_GenStatus(thisWeek)
--   manager = "dsawyer@uber.com"
--   utils.composeMail(manager, "Hello", "<b>Focus:</b> lalalal \n")
-- end
