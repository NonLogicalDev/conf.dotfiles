prefix = require("prefix")

qa = {}
qa.funcs = {}
qa.bar = hs.menubar.new()
qa.title = "QQ"

function qa.mkmenu(title, ...)
  local arg = {...}
  cmp = arg[1]
  if cmp == nil then
    return {title=title}
  elseif type(cmp) == 'function' then
    return {title=title, fn = cmp}
  elseif type(cmp) == 'table' then
    return {title=title, menu = cmp}
  end
end

function qa.update()
  qa.bar:setTitle(qa.title)
  qa.bar:setMenu(qa.menu)
end

qa.menu = {
  qa.mkmenu("Quick Actions"),
  qa.mkmenu("-"),
  qa.mkmenu("Utils")
}
qa.update()

prefix.bind({}, 'q', function() 
  local p = hs.screen.mainScreen():frame().center
  qa.bar:popupMenu(p)
end)

return qa
