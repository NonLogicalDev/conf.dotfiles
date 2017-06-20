prefix = require("prefix")
utils = require("utils")
require("window_manager")


qa = {}
qa.menu = {
  { title = "Work Utils", 
    menu = {
      { title = "Mail GenStatus (This Week)", fn = function () workUtil_GenStatus(1) end },
      { title = "Mail GenStatus (Past Week)", fn = function () workUtil_GenStatus(0) end }
    }
  },
}

qa.bar = hs.menubar.new()
qa.bar:setTitle("QAct")
qa.bar:setMenu(qa.menu)

function workUtil_GenStatus(thisWeek)
  manager = "dsawyer@uber.com"
  utils.composeMail(manager, "Hello", "<b>Focus:</b> lalalal \n")
end
