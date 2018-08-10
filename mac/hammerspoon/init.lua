local utils = require("utils")
local modal = require("modal")
local tmgrid = require("tmgrid")

------------------------------------------------------------------------
--                               Macros                               --
------------------------------------------------------------------------

function M_rgba(r,g,b,a)
  return {
    ["red"] = r, ["blue"] = b, ["green"] = g, ["alpha"] = a
  }
end

------------------------------------------------------------------------
--                             Variables                              --
------------------------------------------------------------------------

local windowMap = {}
local windowSizeStep = 300

local global_grid = nil
local blackoutRects = nil

local jumpPrevWindow = nil

------------------------------------------------------------------------
--                               KeyMap                               --
------------------------------------------------------------------------

function init_keymap() -- {{{
  --------------------
  -- Setting up prefix
  --------------------

  prefix = modal.make({'ctrl', 'alt'}, 'space', " P")

  prefix:bind('', 'escape', function(m)
    -- m:exit() 
  end)

  prefix:bind({'ctrl', 'alt'}, 'space', function(m) 
    -- m:exit()
  end)

  prefix:bind('', 'd', hs.toggleConsole)
  prefix:bind('', 'f', hs.reload)

  function focusApp(appName)
    return function()
      status = hs.application.open(appName)
      if status == nil then
        hs.notify.show('FocusApp', 'Error', 'Could not launch app ' + appName + '.')
      end
    end
  end

  prefix:bind('', '1', focusApp("Wunderlist"))
  prefix:bind('', '2', focusApp("Mail"))
  prefix:bind('', '3', focusApp("uChat"))
  prefix:bind('', '4', focusApp("Firefox"))

  prefix:bind('', '0', function() 
    print(hs.window.focusedWindow():application():name())
  end)

  ------------------
  -- Global Mappings
  ------------------

  hs.hotkey.bind({'ctrl', 'alt'}, 'return', openTerminal)
  prefix:bind({}, '`', hs.toggleConsole)

  -------------------
  -- Language Manager
  -------------------

  prefix:bind({}, 'n', langSwitch("U.S."))
  prefix:bind({}, 'm', langSwitch("Russian - Phonetic"))

  ----------------------
  -- Grid Window Manager
  ----------------------
  
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

  bindGrid(binder, "i", {
    "aab",
    "aab",
  })

  prefix:bind({}, "[", function()
    swapScreens() 
  end)

  prefix:bind({}, "\\", function()
    toggleBlackoutFocusMode() 
  end)

  --------------------
  -- Window operations
  --------------------

  hs.hotkey.bind({'ctrl', 'alt'}, "\\", winSelect)

  prefix:bind({}, "q", winRestoreFrame)
  prefix:bind({'shift'}, "q", winRestoreFrameAll)

  prefix:bind({}, ']', winSaveFrame)
  prefix:bind({'shift'}, "]", winSaveFrameAll)

  -- Expand a window vertically
  prefix:bind({}, 'p', resizeFocusedWindow(function(w,s,f)
    f.y = 0
    f.h = s:frame()._h
    return f
  end))

  ---------------
  -- Window Sizer
  ---------------

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

function flip2D(grid) 
  local uGrid = {}
  for k, v in pairs(grid) do
    uGrid[k] = string.reverse(v)
  end
  return uGrid
end

function rotCW2D(grid) 
  local uGrid = {}
  
  local rowLenMax = 0
  local colLenMax = 0

  for k, v in pairs(grid) do
    local rowLen = string.len(v)
    local colLen = k
    if rowLenMax < rowLen then
      rowLenMax = rowLen
    end
    if colLenMax < colLen then
      colLenMax = colLen
    end
  end

  for i, v in pairs(grid) do
    for j = 1, rowLenMax do
      if uGrid[j] == nil then
        uGrid[j] = {}
      end
      local c = v:sub(j,j)
      uGrid[j][colLenMax-i+1] = c
    end
  end

  return hs.fnutils.map(uGrid, function(v)
    return table.concat(v)
  end)
end

function rotCCW2D(grid) 
  local uGrid = {}
  
  local rowLenMax = 0
  local colLenMax = 0

  for k, v in pairs(grid) do
    local rowLen = string.len(v)
    local colLen = k
    if rowLenMax < rowLen then
      rowLenMax = rowLen
    end
    if colLenMax < colLen then
      colLenMax = colLen
    end
  end

  for i, v in pairs(grid) do
    for j = 1, rowLenMax do
      local jj = rowLenMax-j+1
      if uGrid[jj] == nil then
        uGrid[jj] = {}
      end
      local c = v:sub(j,j)
      uGrid[jj][i] = c
    end
  end

  return hs.fnutils.map(uGrid, function(v)
    return table.concat(v)
  end)
end

function bindGrid(pfx, key, grid, screens) -- {{{
  local aGrid = grid
  local bGrid = flip2D(aGrid)
  local cGrid = rotCW2D(aGrid)
  local dGrid = rotCCW2D(aGrid)

  local winSizeFun = function(rect, hint, screen)
    local w = hs.window.focusedWindow()
    winSetFrame(w, rect)
    winSavePosition(w, true)
  end

  pfx('', key, function() 
    local screens = hs.screen.allScreens()
    local screenMap = {}
    for i, s in pairs(screens) do
      if s:frame().w > s:frame().h then
        screenMap[s:id()] = aGrid
      else
        screenMap[s:id()] = cGrid
      end
    end
    gridShowM(screenMap, screens, winSizeFun)
  end)

  pfx('shift', key, function() 
    local screens = hs.screen.allScreens()
    local screenMap = {}
    for i, s in pairs(screens) do
      if s:frame().w > s:frame().h then
        screenMap[s:id()] = bGrid
      else
        screenMap[s:id()] = dGrid
      end
    end
    gridShowM(screenMap, screens, winSizeFun)
  end)
end -- }}}

function gridShow(grid, screens, winSizeFun, colorFunc)
  local screenMap = {}
  for i, s in pairs(screens) do
    screenMap[s:id()] = grid
  end
  if not(global_grid and global_grid.active == true) then
    global_grid = tmgrid.showGrid(screenMap, screens, winSizeFun, colorFunc)
  end
end
function gridShowM(screenMap, screens, winSizeFun, colorFunc)
  if not(global_grid and global_grid.active == true) then
    global_grid = tmgrid.showGrid(screenMap, screens, winSizeFun, colorFunc)
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

  if not(jumpPrevWindow == nil) then
    jumpPrevWindow:focus()
    jumpPrevWindow = nil
    return
  end

  local curFocusedWindow = hs.window.focusedWindow()

  -- if status == nil then
  --   status = hs.application.open('kitty')
  -- end
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
  else
    jumpPrevWindow = curFocusedWindow
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
  hs.hints.style = 'vimperator'
  hs.hints.titleMaxSize = 10
  -- hs.hints.showTitleThresh = 2
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
  local df = dest_frame


  local width_ratio = df.w / sf.w
  local height_ratio = df.h / sf.h
  
  tf_x1 = df.x1 + ((wf.x1  -  sf.x1) * width_ratio)
  tf_y1 = df.y1 + ((wf.y1  -  sf.y1) * height_ratio)
  tf_x2 = df.x1 + ((wf.x2  -  sf.x1) * width_ratio)
  tf_y2 = df.y1 + ((wf.y2  -  sf.y1) * height_ratio)

  local tf = hs.geometry.rect(tf_x1,tf_y1,tf_x2-tf_x1,tf_y2-tf_y1)

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
  for i, win in pairs(screen_b_wins) do
    reframeWindow(screen_b:frame(), screen_a:frame(), win)
  end

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
    global_grid = nil

    local i = screen2i[screen_id_a]
    hs.notify.show("Screen Selected", "", "#"..i)
    
    colorFunc = function(c_screen_id)
      local screen_num = screen2i[c_screen_id]
      if screen_num == i then
        return {
          ['bcolor'] = M_rgba(1, 0, 0, 1)
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

function toggleBlackoutFocusMode() -- {{{
  if not(blackoutRects == nil) then
    for i, frame in pairs(blackoutRects) do
      frame:delete()
    end
    blackoutRects = nil
  else
    blackoutRects = {}
    local screens = hs.screen.allScreens()

    local screen2i = {}
    local screenid2s = {}
    for i, screen in pairs(screens) do
      screen2i[screen:id()] = i
      screenid2s[screen:id()] = screen
    end

    gridShow({'a'}, screens, function(rect, hint, screen_id_a)
      local screen_idx = screen2i[screen_id_a]
      for i, screen in pairs(screens) do
        if not(i == screen_idx) then

          frame = hs.drawing.rectangle(screen:fullFrame())
          frame:setFillColor(M_rgba(0,0,0,1))

          frame:setLevel("screenSaver")
          frame:show()

          table.insert(blackoutRects, frame)
        end
      end
    end)
  end
end -- }}}

------------------------------------------------------------------------
--                                INIT                                --
------------------------------------------------------------------------

init_keymap()

