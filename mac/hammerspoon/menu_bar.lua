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

function menu_LangSwitch(code)
  return function()
    if code == "EN" then
      hs.keycodes.setLayout("U.S.")
    elseif code == "RU" then
      hs.keycodes.setLayout("Russian - Phonetic")
    end
  end
end

qa.menu = {
  qa.mkmenu("Languages", {
    qa.mkmenu("English", menu_LangSwitch("EN")),
    qa.mkmenu("Russian", menu_LangSwitch("RU")),
  }),
  qa.mkmenu("-"),
  qa.mkmenu("Exit")
}
qa.update()

prefix.bind({}, 'q', function() 
  local p = hs.screen.mainScreen():frame().center
  qa.bar:popupMenu(p)
end)

prefix.bind({}, 'n', function() 
  menu_LangSwitch("EN")()
end)

prefix.bind({}, 'm', function() 
  menu_LangSwitch("RU")()
end)

return qa
