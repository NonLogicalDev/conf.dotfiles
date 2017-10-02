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

function bindGrid(key, grid, screens) -- {{{
  local uGrid = {}
  for k,v in pairs(grid) do
    uGrid[k] = string.reverse(v)
  end

  prefix.bind('', key, function() 
    if not(ggrid and ggrid.active == true) then
      ggrid = tmgrid.showGrid(grid, hs.screen.allScreens())
    end
  end)

  prefix.bind('shift', key, function() 
    if not(ggrid and ggrid.active == true) then
      ggrid = tmgrid.showGrid(uGrid, hs.screen.allScreens())
    end
  end)
end -- }}}

function winSelect() -- {{{
  -- hs.hints.style = 'vimperator'
  hs.hints.windowHints(nil, function(selWin) 
    selWin:focus()
  end)
end -- }}}

------------------------------------------------------------------------
--                           Configuration                            --
------------------------------------------------------------------------

prefix.bind('', '`', hs.toggleConsole)
prefix.bind('', 'r', hs.reload)

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

prefix.bind({}, 'n', function() 
  langSwitch("EN")()
end)

prefix.bind({}, 'm', function() 
  langSwitch("RU")()
end)

hs.hotkey.bind({'ctrl', 'alt'}, "\\", function() 
  winSelect()
end)

prefix.bind('', "\\", function() 
  winSelect()
end)

bindGrid("g", {
  "aab",
  "aab",
  "aac"
})

bindGrid("f", {
  "aaaabbbbbccc",
})

bindGrid("b", {
  "abc",
  "abc",
})

bindGrid("v", {
  "aaabbbbb",
})

bindGrid("c", {
  "bbbbbaaa",
  "bbbbbaaa",
  "bbbbbccc", 
})

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
