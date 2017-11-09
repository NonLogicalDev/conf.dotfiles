local module = {}

local TIMEOUT = 5

local modal = hs.hotkey.modal.new({'ctrl', 'alt'}, 'space')

function modal:entered()
  alertStyle = {
    strokeWidth = 5,
    textSize = 30,
    radius = 0,
  }
  modal.alertId = hs.alert.show(" P", alertStyle, 9999)
  module.startTimeout()
end

function modal:exited()
  if modal.alertId then
    hs.alert.closeSpecific(modal.alertId, 0.3)
  end
  module.cancelTimeout()
end

-- function modal:entered()
--     alertStyle = {
--       strokeWidth = 5,
--       radius = 0,
--     }
--
--     modal.timer = hs.timer.doAfter(TIMEOUT, function() modal:exit() end)
-- end
--
-- function modal:exited()
--     if modal.alertId then
--         hs.alert.closeSpecific(modal.alertId)
--     end
--     module.cancelTimeout()
-- end


function module.startTimeout()
  modal.timer = hs.timer.doAfter(TIMEOUT, function()
    module.exit()
  end)
end

function module.cancelTimeout()
  if modal.timer then
    modal.timer:stop()
  end
end

function module.exit()
  modal:exit()
end

function module.bind(mod, key, fn)
  modal:bind(mod, key, nil, function() fn(); module.exit() end)
end

function module.bindMultiple(mod, key, pressedFn, releasedFn, repeatFn)
  modal:bind(mod, key, pressedFn, releasedFn, repeatFn)
end

module.bind('', 'escape', module.exit)
module.bind({'ctrl', 'alt'}, 'space', module.exit)

module.bind('', 'd', hs.toggleConsole)
module.bind('', 'r', hs.reload)

------------------------------------------------------------------------
--                         Utility Functions                          --
------------------------------------------------------------------------


function _drawRect(text,rect,borderWidth) -- {{{
  local borderColor = {
    ["red"]   = 1,
    ["blue"]  = 1,
    ["green"] = 1,
    ["alpha"] = 0.80
  }
  local fillColor = {
    ["red"]   = 0.0,
    ["blue"]  = 0.0,
    ["green"] = 0.0,
    ["alpha"] = 0.5
  }
  local textColor = {
    ["red"]   = 0.1,
    ["blue"]  = 0.1,
    ["green"] = 0.1,
    ["alpha"] = 1
  }

  local f = rect
  local s = borderWidth

  local fx = f.x - s/2
  local fy = f.y - s/2
  local fw = f.w + s
  local fh = f.h + s

  local ts = 40
  local htf = {w=150,h=150}

  htf.x = f.x + f.w/2 - htf.w/2 
  htf.y = f.y + f.h/2 - htf.h/2


  -- Drawing frame
  local frame = hs.drawing.rectangle(rect)

  -- frame:setRoundedRectRadii(5.0, 5.0)
  frame:setStrokeWidth(borderWidth)
  frame:setStrokeColor(borderColor)
  frame:setFillColor(fillColor)
  frame:setStroke(true):setFill(true)

  frame:setLevel("floating")
  frame:show()

  -- Drawing text
  local text = hs.drawing.text(htf, text)
  text:setTextSize(ts)
  text:setTextFont('Lucida Grande')
  text:setTextStyle({
    ['alignment'] = 'center'
  })

  text:show()

  return {
    ['frame'] = frame,
    ['text'] = text
  }
end -- }}}

return module
