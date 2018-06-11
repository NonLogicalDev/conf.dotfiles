local module = {}
local TIMEOUT = 5

-- Modal Module
------------------------------------------------------------------------
local Modal = {}
Modal.__index = Modal
------------------------------------------------------------------------

local tm = {}

function module.make(mods, key, msg)
  -- local modal = hs.hotkey.modal.new({'ctrl', 'alt'}, 'space')
  local self = setmetatable({}, Modal)
  local modal = hs.hotkey.modal.new(mods, key)

  function modal:entered()
    alertStyle = {
      strokeWidth = 5,
      textSize = 30,
      radius = 0,
    }
    modal.alertId = hs.alert.show(msg, alertStyle, 9999)
    module.startTimeout(modal)
  end

  function modal:exited()
    if modal.alertId then
      hs.alert.closeSpecific(self.alertId, 0.3)
    end
    module.cancelTimeout()
  end

  self.modal = modal
  return self
end

function Modal.exit(self)
  self.modal:exit()
end

function Modal.bind(self, mod, key, fn)
  m = self.modal
  self.modal:bind(mod, key, nil, function() fn(); m:exit() end)
end

function Modal.bindMultiple(self, mod, key, pressedFn, releasedFn, repeatFn)
  self.modal:bind(mod, key, pressedFn, releasedFn, repeatFn)
end

------------------------------------------------------------------------
--                             Utilities                              --
------------------------------------------------------------------------

function module.startTimeout(modal)
  tm.timer = hs.timer.doAfter(TIMEOUT, function()
    modal:exit()
  end)
end

function module.cancelTimeout()
  if tm.timer then
    tm.timer:stop()
  end
end

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

------------------------------------------------------------------------
--                               UNUSED                               --
------------------------------------------------------------------------


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

