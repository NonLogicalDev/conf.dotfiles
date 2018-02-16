local utils = require("utils")
local prefix = require("prefix")
local tmgrid = require("tmgrid")
local qa = require("menubar")

------------------------------------------------------------------------
--                             Variables                              --
------------------------------------------------------------------------

local ggrid = nil
local windowYankBuffer = nil
local windowMap = {}
local windowSizeStep = 300

------------------------------------------------------------------------
--                               KeyMap                               --
------------------------------------------------------------------------

function init_keymap() -- {{{
  print("STARTING")

  -- Global Mappings

  prefix.bind({}, '`', hs.toggleConsole)
  prefix.bind({}, '\\', hs.reload)

  -- Language Manager

  prefix.bind({}, 'n', langSwitch("U.S."))
  prefix.bind({}, 'm', langSwitch("Russian - Phonetic"))

  -- Grid Window Manager

  -- bindGrid(prefix, "q", {
  --   "abc",
  --   "abc",
  -- })

  bindGrid(prefix, "w", {
    "aaaabbbbbccc",
  })

  bindGrid(prefix, "e", {
    "bbbbbbaaaa",
    "bbbbbbaaaa",
    "bbbbbbcccc", 
  })

  bindGrid(prefix, "r", {
    "aaaaaabbbb",
  })

  bindGrid(prefix, "t", {
    "aaaaaabbbb",
    "aaaaaabbbb",
    "aaaaaabbbb",
    "aaaaaacccc", 
    "aaaaaacccc", 
  })

  bindGrid(prefix, "y", {
    "aaaaaabbbb",
  })

  -- Window operations
  
  hs.hotkey.bind({'ctrl', 'alt'}, "\\", winSelect)
  
  prefix.bind({}, "q", winRestoreFrame)
  prefix.bind({'shift'}, "q", winSaveFrameAll)

  prefix.bind({}, 'h', hs.window.focusWindowWest)
  prefix.bind({}, 'j', hs.window.focusWindowSouth)
  prefix.bind({}, 'k', hs.window.focusWindowNorth)
  prefix.bind({}, 'l', hs.window.focusWindowEast)

  --# Expand a window vertically
  prefix.bind({}, 'p', resizeFocusedWindow(function(w,s,f)
    f.y = 0
    f.h = s:frame()._h
    return f
  end))

  -- Window Sizer
  
  local winSizeMult = 0.2

  prefix.bind({'shift'}, 'h', resizeFocusedWindow(function(w,s,f)
      local step = winSizeMult * s:frame()._w
      f.x = f.x - step
      f.w = f.w + step
      return f
  end))

  prefix.bind({'shift'}, 'j', resizeFocusedWindow(function(w,s,f)
      local step = winSizeMult * s:frame()._h
      f.h = f.h + windowSizeStep
      return f
  end))

  prefix.bind({'shift'}, 'k', resizeFocusedWindow(function(w,s,f)
    local step = winSizeMult * s:frame()._h
    f.y = f.y - step
    f.h = f.h + step
    return f
  end))

  prefix.bind({'shift'}, 'l', resizeFocusedWindow(function(w,s,f)
      local step = winSizeMult * s:frame()._w
      f.w = f.w + step
      return f
  end))

end -- }}}

------------------------------------------------------------------------
--                            Helper Utils                            --
------------------------------------------------------------------------
function langSwitch(code) -- {{{
  return function()
    hs.keycodes.setLayout(code)
    hs.notify.show("Landguage", "", "Switched to "..code)
  end
end -- }}}

function winSetFrame(w, f) -- {{{
  w:setFrame(f, 0)
end -- }}}

function winSavePosition(w, notify) -- {{{
  windowMap[w:id()] = w:frame()
  print(notify)
  if notify == true then
    hs.notify.show("Window Position", "Success", "Window position saved...")
  end
end -- }}}

function winLoadPosition(w, notify) -- {{{
  rect = windowMap[w:id()]
  if rect == nil then
    print("Window lacks rect info")
    if notify == true then
      hs.notify.show("Window Position", "Error", "Window lacks rect info...")
    end
  else
    winSetFrame(w, rect)
  end
end -- }}}

function resizeFocusedWindow(fn)
  return function()
    local w = hs.window.focusedWindow()
    local s = w:screen()
    winSetFrame(w, fn(w, s, w:frame()))
  end
end

function bindGrid(pfx, key, grid, screens) -- {{{
  local uGrid = {}
  for k, v in pairs(grid) do
    uGrid[k] = string.reverse(v)
  end

  local winSizeFun = function(rect, hint)
    local w = hs.window.focusedWindow()
    winSetFrame(w, rect)
    winSavePosition(w, true)
  end

  pfx.bind('', key, function() 
    if not(ggrid and ggrid.active == true) then
      ggrid = tmgrid.showGrid(grid, hs.screen.allScreens(), winSizeFun)
    end
  end)

  pfx.bind('shift', key, function() 
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


function winSaveFrameAll()
  for i, win in pairs(hs.window.allWindows()) do
    winSavePosition(win, false)
  end
end

function winSaveFrame()
  winSavePosition(hs.window.focusedWindow(), true)
end

function winRestoreFrame()
  winLoadPosition(hs.window.focusedWindow(), true)
end

------------------------------------------------------------------------
--                              CHUNKWM                               --
------------------------------------------------------------------------

-- hyper_mod = {'ctrl', 'alt', 'cmd'}
--
-- function cwmap(mods, key, args)
--   hs.hotkey.bind(mods, key, function()
--     out, st, ty, rc = hs.execute('/usr/local/bin/chunkc ' .. args)
--     print(st, out, args)
--   end)
-- end
--
-- cwmap(hyper_mod , 'h'     , 'tiling::window --focus west')
-- cwmap(hyper_mod , 'left'  , 'tiling::window --focus west')
--
-- cwmap(hyper_mod , 'j'     , 'tiling::window --focus south')
-- cwmap(hyper_mod , 'down'  , 'tiling::window --focus south')
--
-- cwmap(hyper_mod , 'k'     , 'tiling::window --focus north')
-- cwmap(hyper_mod , 'up'    , 'tiling::window --focus north')
--
-- cwmap(hyper_mod , 'l'     , 'tiling::window --focus east')
-- cwmap(hyper_mod , 'right' , 'tiling::window --focus east')
--
-- cwmap(hyper_mod , 'p' , 'tiling::window --toggle parent')
-- cwmap(hyper_mod , 'f' , 'tiling::window --toggle fullscreen')
--
-- cwmap(hyper_mod , 'm' , 'set bsp_split_mode vertical')
-- cwmap(hyper_mod , 'n' , 'set bsp_split_mode horizontal')
--
--
-- cwmap({'alt'}, 'a', 'tiling::desktop --layout bsp')
-- cwmap({'alt'}, 's', 'tiling::desktop --layout monocle')
-- cwmap({'alt'}, 'd', 'tiling::desktop --layout float')
--
-- cwmap({'alt'}, 'q', 'tiling::desktop --toggle offset')
--
-- for i=1,9 do  -- -- -- -- -- -- -- -- -- --
------------------------------------------------------------------------
--   cwmap({'shift', 'alt'}, is, 'tiling::window --send-to-desktop ' .. is)
-- end
--
-- cwmap({'shift', 'alt'}, 'space', 'tiling::window --toggle float')


------------------------------------------------------------------------
--                               Unused                               --
------------------------------------------------------------------------

-- function langSwitch(code) -- {{{
--   return function()
--     if code == "EN" then
--       hs.keycodes.setLayout("U.S.")
--     elseif code == "RU" then
--       hs.keycodes.setLayout("Russian - Phonetic")
--     end
--   end
-- end -- }}}


-- function windowYank() -- {{{
--   local w = hs.window.focusedWindow()
--
--   windowYankBuffer = {}
--   windowYankBuffer['win_id'] = w:id()
--
--   print(windowYankBuffer['win_id'])
-- end -- }}}
-- function windowPut() -- {{{
--   if not(windowYankBuffer) then
--     print("Window Buffer not set")
--     return 
--   end
--   local win_id = windowYankBuffer['win_id']
--   print(windowYankBuffer['win_id'])
--
--   local w = hs.window.find(win_id)
--   if not(w) then 
--     print("No window with id")
--     return
--   end
--
--   local cur_screen = hs.screen.mainScreen()
--   local scs = hs.screen.allScreens()
--
--   tmgrid.showGrid({'.'}, scs, function(rect, hint) 
--     local screen_num = tonumber(string.sub(hint, 0, 1))
--     w:moveToScreen(scs[screen_num])
--   end)
-- end -- }}}

-- bindGrid("g", {
--   "aab",
--   "aab",
--   "aac"
-- })

-- hs.hotkey.bind({'ctrl', 'alt'}, "=", function() 
--   local screens = hs.screen.allScreens()
--
--   local rotations = {
--     [722475280] = 0,
--     [722496271] = 0,
--   }
--
--   for i, screen  in ipairs(screens) do
--     local screen_id = screen:id()
--     if not(rotations[screen_id] == nil) then
--       screen:rotate(rotations[screen_id])
--     end
--   end
--
--   for i, screen  in ipairs(hs.screen.allScreens()) do
--     print("Name:" .. screen:name())
--     print("ID:" .. tostring(screen:id()))
--     print("Rotation:" .. tostring(screen:rotate()))
--     print("-------------")
--   end
-- end)

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
--
--

------------------------------------------------------------------------
--                                INIT                                --
------------------------------------------------------------------------

init_keymap()

