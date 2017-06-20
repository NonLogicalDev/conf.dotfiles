utils = {}

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

return utils
