-- Alex's Hammerspoon config file
-- Visit http://www.hammerspoon.org/go/ for a configuration tutorial

-- Reload config with alt+shift+R
hs.hotkey.bind({"alt", "shift"}, "R", function () hs.reload() end)

-- TODO Modal resize bindings with a mode indicator in the status bar

--resizeMode = hs.hotkey.modal.new()
--
--hs.hotkey.bind({"alt"}, "R", function ()
--    resizeMode:enter()
--    hs.alert.show("Resize mode")
--end)
--
--resizeMode:bind({}, "escape", function ()
--    resizeMode:exit()
--    hs.alert.show("Normal mode")
--end)
--
--hs.grid.MARGINX = 10
--hs.grid.MARGINY = 10
--hs.grid.GRIDHEIGHT = 3
--hs.grid.GRIDWIDTH = 7
--
--resizeMode:bind({}, "H", function ()
--    local win = hs.window.focusedWindow()
--    local f = win:frame()
--    local max = win:screen():frame()
--    local newX = math.max(0, f.x - 40)
--    local newW = f.w + (f.x - newX)
--    f.x = newX
--    f.w = newW
--    win:setFrame(f)
--end)
--
--resizeMode:bind({}, "L", function ()
--    local win = hs.window.focusedWindow()
--    local f = win:frame()
--    local max = win:screen():frame()
--    f.w = math.min(f.w + 40, max.w - f.x)
--    win:setFrame(f)
--end)
--
--resizeMode:bind({}, "K", function ()
--    local win = hs.window.focusedWindow()
--    local f = win:frame()
--    local max = win:screen():frame()
--    local newY = math.max(0, f.y - 40)
--    local newH = f.h + (f.y - newY)
--    f.y = newY
--    f.h = newH
--    win:setFrame(f)
--end)

hs.window.animationDuration = 0

hs.hotkey.bind({"alt"}, "L", function ()
    hs.window.filter.focusEast()
end)

hs.hotkey.bind({"alt"}, "H", function ()
    hs.window.filter.focusWest()
end)

hs.hotkey.bind({"alt"}, "J", function ()
    hs.window.filter.focusSouth()
end)

hs.hotkey.bind({"alt"}, "K", function ()
    hs.window.filter.focusNorth()
end)

gubbins = 0
function toggler()
    gubbins = (gubbins + 1) % 4
    return gubbins
end

factors =
    { ["NW"] = { x = 0     , y = 0     , w = 1 / 2 , h = 1 / 2 }
    , ["N" ] = { x = 0     , y = 0     , w = 1     , h = 1 / 2 }
    , ["NE"] = { x = 1 / 2 , y = 0     , w = 1 / 2 , h = 1 / 2 }
    , ["E" ] = { x = 1 / 2 , y = 0     , w = 1 / 2 , h = 1     }
    , ["SE"] = { x = 1 / 2 , y = 1 / 2 , w = 1 / 2 , h = 1 / 2 }
    , ["S" ] = { x = 0     , y = 1 / 2 , w = 1     , h = 1 / 2 }
    , ["SW"] = { x = 0     , y = 1 / 2 , w = 1 / 2 , h = 1 / 2 }
    , ["W" ] = { x = 0     , y = 0     , w = 1 / 2 , h = 1     }
    , ["L" ] = { x = 0     , y = 0     , w = 1 / 3 , h = 1     }
    , ["LT"] = { x = 0     , y = 0     , w = 1 / 3 , h = 1 / 2 }
    , ["LB"] = { x = 0     , y = 1 / 2 , w = 1 / 3 , h = 1 / 2 }
    , ["C" ] = { x = 1 / 3 , y = 0     , w = 1 / 3 , h = 1     }
    , ["CT"] = { x = 1 / 3 , y = 0     , w = 1 / 3 , h = 1 / 2 }
    , ["CB"] = { x = 1 / 3 , y = 1 / 2 , w = 1 / 3 , h = 1 / 2 }
    , ["R" ] = { x = 2 / 3 , y = 0     , w = 1 / 3 , h = 1     }
    , ["RT"] = { x = 2 / 3 , y = 0     , w = 1 / 3 , h = 1 / 2 }
    , ["RB"] = { x = 2 / 3 , y = 1 / 2 , w = 1 / 3 , h = 1 / 2 }
    }

function setActiveWindowPosition(dir)
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local max = win:screen():frame()
    mod = factors[dir]
    f.x = max.x + (max.w * mod.x)
    f.y = max.y + (max.h * mod.y)
    f.w = max.w * mod.w
    f.h = max.h * mod.h
    win:setFrame(f)
end

hs.hotkey.bind({"alt", "shift"}, "space", function ()
    hs.window.focusedWindow():maximize()
end)

hs.hotkey.bind({"alt", "shift"}, "L", function ()
    setActiveWindowPosition("E")
end)

hs.hotkey.bind({"alt", "shift"}, "H", function ()
    setActiveWindowPosition("W")
end)

hs.hotkey.bind({"alt", "shift"}, "J", function ()
    pos = toggler()
    if (pos % 2) == 0 then setActiveWindowPosition("S")
    elseif pos == 1   then setActiveWindowPosition("SW")
    elseif pos == 3   then setActiveWindowPosition("SE")
    end
end)

hs.hotkey.bind({"alt", "shift"}, "K", function ()
    pos = toggler()
    if (pos % 2) == 0 then setActiveWindowPosition("N")
    elseif pos == 1   then setActiveWindowPosition("NW")
    elseif pos == 3   then setActiveWindowPosition("NE")
    end
end)

hs.hotkey.bind({"alt", "shift"}, "U", function ()
    pos = toggler()
    if (pos % 2) == 0 then setActiveWindowPosition("L")
    elseif pos == 1   then setActiveWindowPosition("LT")
    elseif pos == 3   then setActiveWindowPosition("LB")
    end
end)

hs.hotkey.bind({"alt", "shift"}, "I", function ()
    pos = toggler()
    if (pos % 2) == 0 then setActiveWindowPosition("C")
    elseif pos == 1   then setActiveWindowPosition("CT")
    elseif pos == 3   then setActiveWindowPosition("CB")
    end
end)

hs.hotkey.bind({"alt", "shift"}, "O", function ()
    pos = toggler()
    if (pos % 2) == 0 then setActiveWindowPosition("R")
    elseif pos == 1   then setActiveWindowPosition("RT")
    elseif pos == 3   then setActiveWindowPosition("RB")
    end
end)

hs.alert.show("Hammerspoon config loaded")
