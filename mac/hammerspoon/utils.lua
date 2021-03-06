utils = {}

function utils.length(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function utils.urlencode(str)
  if (str) then
    str = string.gsub (str, "\n", "\r\n")
    str = string.gsub (str, "([^%w ])",
    function (c) return string.format ("%%%02X", string.byte(c)) end)
    str = string.gsub (str, " ", "+")
  end
  return str    
end

function utils.composeMail(target, subject, body)
  script = string.format([[
set htmlContent to "<html><body><h1>Hello,</h1><p>world.</p></body></html>"
set recipientList to {"person1@example.com", "person2@example.com"}
set msgSubject to "qwerty"
tell application "Mail"
    set newMessage to make new outgoing message with properties {subject:"%s", html content:"<html><body>%s</body></html>"}
    tell newMessage
        set visible to true
        make new to recipient at end of to recipients with properties {address:"%s"}
    end tell
    activate
    set lastWindowID to id of window 1
end tell]],subject, body, target)
  print(script)
  hs.osascript.applescript(script)
end

function utils.has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

function utils.windowBorderEnable()
  excludedApps = {
    "Alfred 3",
    "Bartender 2",
    "1Password mini"
  }

  border = nil
  function drawBorder(f, s)
    local fx = f.x - s/2
    local fy = f.y - s/2
    local fw = f.w + s
    local fh = f.h + s

    local border = hs.drawing.rectangle(
      hs.geometry.rect(fx, fy, fw, fh)
    )

    border:setStroke(true)
    border:setStrokeWidth(s)
    border:setStrokeColor({
      ["red"]=0.75,
      ["blue"]=0.0,
      ["green"]=0.0,
      ["alpha"]=0.80
    })

    border:setFill(true)
    border:setFillColor({
      ["red"]=0.75,
      ["blue"]=0.0,
      ["green"]=0.0,
      ["alpha"]=0.00
    })

    border:setRoundedRectRadii(10.0, 10.0)
    border:setLevel("floating")

    border:show()

    return border
  end

  function updateBorder()
    if border then
      border:delete()
    end

    if not(hs.application.find("Amethyst")) then
      return
    end

    local win = hs.window.focusedWindow()
    if win == nil then return end

    local winAppName = win:application():name()
    if utils.has_value(excludedApps, winAppName) then
      return
    end

    border = drawBorder(win:frame(), 7)
  end

  windows = hs.window.filter.new(nil)
  windows:subscribe(hs.window.filter.windowFocused, function () updateBorder() end)
  windows:subscribe(hs.window.filter.windowUnfocused, function () updateBorder() end)
  windows:subscribe(hs.window.filter.windowMoved, function () updateBorder() end)
  windows:subscribe(hs.window.filter.windowDestroyed, function () updateBorder() end)

  -- This is a catch all case just in case
  hs.timer.new(0.5, function() updateBorder() end):start()
end

return utils
