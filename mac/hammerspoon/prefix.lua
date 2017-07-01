local module = {}

local TIMEOUT = 5

local modal = hs.hotkey.modal.new({'ctrl', 'alt'}, 'space')

function modal:entered()
    alertStyle = {
      strokeWidth = 5,
      radius = 0,
    }

    modal.alertId = hs.alert.show("Prefix Mode", alertStyle, 9999)
    modal.timer = hs.timer.doAfter(TIMEOUT, function() modal:exit() end)
end

function modal:exited()
    if modal.alertId then
        hs.alert.closeSpecific(modal.alertId)
    end
    module.cancelTimeout()
end

function module.exit()
    modal:exit()
end

function module.cancelTimeout()
    if modal.timer then
        modal.timer:stop()
    end
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

return module
