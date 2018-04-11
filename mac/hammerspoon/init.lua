local utils = require("utils")
local modal = require("modal")
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

local lastEvent = nil

function init_keymap() -- {{{
  -- Setting up prefix

  prefix = modal.make({'ctrl', 'alt'}, 'space', " P")

  prefix:bind('', 'escape', function()
    prefix:exit() 
  end)

  prefix:bind({'ctrl', 'alt'}, 'space', function() 
    prefix:exit()
  end)

  prefix:bind('', 'd', hs.toggleConsole)
  prefix:bind('', 'r', hs.reload)

  -- Global Mappings

  hs.hotkey.bind({'ctrl', 'alt'}, 'return', openTerminal)


  prefix:bind({}, '`', hs.toggleConsole)

  -- prefix:bind({}, '\\', hs.reload)

  -- function sendKeyStroke(mods, key)
  --   return function()
  --     hs.eventtap.keyStroke(mods, key)
  --   end
  -- end
  -- hs.hotkey.bind({'ctrl', 'shift'}, '[', sendKeyStroke({'cmd', 'shift'}, '['))
  -- hs.hotkey.bind({'ctrl', 'shift'}, ']', sendKeyStroke({'cmd', 'shift'}, ']'))

  -- Language Manager

  prefix:bind({}, 'n', langSwitch("U.S."))
  prefix:bind({}, 'm', langSwitch("Russian - Phonetic"))

  -- Grid Window Manager
  binder = function(mods, key, fn)
    prefix:bind(mods, key, fn)
  end


  bindGrid(binder, "w", {
    "aaaabbbbbccc",
  })

  bindGrid(binder, "e", {
    "ab",
  })

  bindGrid(binder, "r", {
    "aaaaaabbbb",
  })

  bindGrid(binder, "t", {
    "aaaaaabbbb",
    "aaaaaabbbb",
    "aaaaaabbbb",
    "aaaaaacccc", 
    "aaaaaacccc", 
  })

  bindGrid(binder, "y", {
    "ab",
    "cd",
  })

  bindGrid(binder, "u", {
    "abc",
    "abc",
  })

  prefix:bind({}, "[", function()
    swapScreens() 
  end)

  -- Window operations

  hs.hotkey.bind({'ctrl', 'alt'}, "\\", winSelect)

  prefix:bind({}, "q", winRestoreFrame)
  prefix:bind({'shift'}, "q", winRestoreFrameAll)

  prefix:bind({}, ']', winSaveFrame)
  prefix:bind({'shift'}, "]", winSaveFrameAll)

  prefix:bind({}, 'h', hs.window.focusWindowWest)
  prefix:bind({}, 'j', hs.window.focusWindowSouth)
  prefix:bind({}, 'k', hs.window.focusWindowNorth)
  prefix:bind({}, 'l', hs.window.focusWindowEast)

  --# Expand a window vertically
  prefix:bind({}, 'p', resizeFocusedWindow(function(w,s,f)
    f.y = 0
    f.h = s:frame()._h
    return f
  end))

  -- Window Sizer

  local winSizeMult = 0.2

  prefix:bind({'shift'}, 'h', resizeFocusedWindow(function(w,s,f)
      local step = winSizeMult * s:frame()._w
      f.x = f.x - step
      f.w = f.w + step
      return f
  end))

  prefix:bind({'shift'}, 'j', resizeFocusedWindow(function(w,s,f)
      local step = winSizeMult * s:frame()._h
      f.h = f.h + windowSizeStep
      return f
  end))

  prefix:bind({'shift'}, 'k', resizeFocusedWindow(function(w,s,f)
    local step = winSizeMult * s:frame()._h
    f.y = f.y - step
    f.h = f.h + step
    return f
  end))

  prefix:bind({'shift'}, 'l', resizeFocusedWindow(function(w,s,f)
      local step = winSizeMult * s:frame()._w
      f.w = f.w + step
      return f
  end))

end -- }}}

------------------------------------------------------------------------
--                            Helper Utils                            --
------------------------------------------------------------------------

function gridShow(grid, screens, winSizeFun, colorFunc)
  if not(ggrid and ggrid.active == true) then
    ggrid = tmgrid.showGrid(grid, screens, winSizeFun, colorFunc)
  end
end

function langSwitch(code) -- {{{
  return function()
    hs.keycodes.setLayout(code)
    hs.notify.show("Landguage", "", "Switched to "..code)
  end
end -- }}}

function openTerminal()
  local status = nil
  if status == nil then
    status = hs.application.open('kitty')
  end
  if status == nil then
    status = hs.application.open('iTerm')
    -- iTerm seems to be having problems and always returns nil
    if hs.window.focusedWindow():application():name() == 'iTerm2' then
      status = true
    end
  end
  if status == nil then
    status = hs.application.open('Terminal')
    print(status)
  end
  if status == nil then
    hs.notify.show('Terminal', 'Error', 'Could not launch any terminal.')
  end
end

------------------------------------------------------------------------
--                       Window Manager Helpers                       --
------------------------------------------------------------------------

function winSetFrame(w, f) -- {{{
  w:setFrame(f, 0)
end -- }}}

function resizeFocusedWindow(fn)
  return function()
    local w = hs.window.focusedWindow()
    local s = w:screen()
    winSetFrame(w, fn(w, s, w:frame()))
  end
end

function winSelect() -- {{{
  -- hs.hints.style = 'vimperator'
  hs.hints.windowHints(nil, function(selWin) 
    selWin:focus()
  end)
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

function winSaveFrame()
  winSavePosition(hs.window.focusedWindow(), true)
end

function winSaveFrameAll()
  for i, win in pairs(hs.window.allWindows()) do
    winSavePosition(win, false)
  end
  hs.notify.show("Window Position (ALL)", "Success", "Window position saved...")
end

function winRestoreFrame()
  winLoadPosition(hs.window.focusedWindow(), true)
end

function winRestoreFrameAll()
  for i, win in pairs(hs.window.allWindows()) do
    winLoadPosition(win, true)
  end
end

function reframeWindow(src_frame, dest_frame, win)
  local wf = win:frame()

  local sf = src_frame
  local df = src_frame

  local tf = hs.geometry.rect(0,0,0,0)

  local width_ratio = 1 -- df.w / sf.w
  local height_ratio = 1 -- df.h / sf.h
  
  tf.x1 = df.x1 + ((wf.x1  -  sf.x1) * width_ratio)
  tf.y1 = df.y1 + ((wf.y1  -  sf.y1) * height_ratio)
  tf.x2 = df.x1 + ((wf.x2  -  sf.x1) * width_ratio)
  tf.y2 = df.y1 + ((wf.y2  -  sf.y1) * height_ratio)

  print("SET FRAME:")
  print(win, win:frame(), tf)

  winSetFrame(win, tf)
end

function swapScreenWindows(screen_a, screen_b)
  local screen_a_id = screen_a:id()
  local screen_b_id = screen_b:id()

  local screen_a_rect = screen_a:frame()
  local screen_b_rect = screen_b:frame()

  local screen_a_wins = {}
  local screen_b_wins = {}

  for i, win in pairs(hs.window.allWindows()) do
    local w_screen = win:screen()

    if w_screen:id() == screen_a_id then
      table.insert(screen_a_wins, win)
    end

    if w_screen:id() == screen_b_id then
      table.insert(screen_b_wins, win)
    end
  end

  for i, win in pairs(screen_a_wins) do
    reframeWindow(screen_a:frame(), screen_b:frame(), win)
  end
  -- for i, win in pairs(screen_b_wins) do
  --   reframeWindow(screen_b:frame(), screen_a:frame(), win)
  -- end

  print("ScreenSwap", "", ("s1:"..#screen_a_wins) .. " " .. ("s2:"..#screen_b_wins))
end

function swapScreens() -- {{{
  local screens = hs.screen.allScreens()

  local screen2i = {}
  local screenid2s = {}

  for i, screen in pairs(screens) do
    screen2i[screen:id()] = i
    screenid2s[screen:id()] = screen
  end

  gridShow({'a'}, screens, function(rect, hint, screen_id_a)
    -- Selected First Screen
    ggrid = nil

    local i = screen2i[screen_id_a]
    hs.notify.show("Screen Selected", "", "#"..i)
    
    colorFunc = function(c_screen_id)
      local screen_num = screen2i[c_screen_id]
      if screen_num == i then
        return {
          ['bcolor'] = {
            ["red"]   = 1.0,
            ["blue"]  = 0.0,
            ["green"] = 0.0,
            ["alpha"] = 0.80
          }
        }
      end
      return {}
    end
    gridShow({'a'}, screens, function(rect, hint, screen_id_b)
      -- Selected second screen
      swapScreenWindows(screenid2s[screen_id_a], screenid2s[screen_id_b])
    end, colorFunc)
  end)
end

function bindGrid(pfx, key, grid, screens) -- {{{
  local uGrid = {}
  for k, v in pairs(grid) do
    uGrid[k] = string.reverse(v)
  end

  local winSizeFun = function(rect, hint, screen)
    local w = hs.window.focusedWindow()
    winSetFrame(w, rect)
    winSavePosition(w, true)
  end

  -- colorConf = {
  --   ['bcolor'] = {
  --     ["red"]   = 1,
  --     ["blue"]  = 0,
  --     ["green"] = 0,
  --     ["alpha"] = 0.80
  --   }
  -- }
  -- colorConf2 = {
  --   ['bcolor'] = {
  --     ["red"]   = 0,
  --     ["blue"]  = 1,
  --     ["green"] = 0,
  --     ["alpha"] = 0.80
  --   }
  -- }

  pfx('', key, function() 
    gridShow(grid, hs.screen.allScreens(), winSizeFun)
  end)

  pfx('shift', key, function() 
    gridShow(uGrid, hs.screen.allScreens(), winSizeFun)
  end)
end -- }}}


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

-- Welp that did not work out =[
-- Focus Follows mouse is incredibly hard to implement
--
-- local mouseMoved = false
-- local activeWindow = nil
--
-- hs.eventtap.new({hs.eventtap.event.types['mouseMoved']}, function(e)
--   mouseMoved = true
-- end):start()
--
-- hs.timer.doEvery(0.1, function() 
--   if mouseMoved then
--     local my_pos = hs.geometry.new(hs.mouse.getAbsolutePosition())
--     local my_screen = hs.mouse.getCurrentScreen()
--
--     window = hs.fnutils.find(hs.window.orderedWindows(), function(w)
--       return my_screen == w:screen() and my_pos:inside(w:frame())
--     end)
--     print(hs.inspect(window, 2), mouseMoved)
--     -- mouseMoved = false
--   end
-- end)

-- keyTimes = {}
--
-- hs.eventtap.new({hs.eventtap.event.types['keyDown'], hs.eventtap.event.types['keyUp']}, function(e)
-- if not(e == nil) then
--   local etype = e:getType()
--   local ekey = e:getKeyCode()
--   local etime = hs.timer.absoluteTime() 
--   
--   if etype == hs.eventtap.event.types['keyDown'] then
--     if keyTimes[ekey] ~= nil then
--       keyTimes[ekey] = etime
--     end
--   elseif etype == hs.eventtap.event.types['keyUp'] then
--     local etimelapse = keyTimes[ekey]
--
--     if not(etimelaps == nil) then
--       print(etime - keyTimes[ekey])
--       keyTimes[ekey] = nil
--     end
--   end
-- end
--
-- return false, e
-- end):start()

------------------------------------------------------------------------
--                                INIT                                --
------------------------------------------------------------------------

init_keymap()

