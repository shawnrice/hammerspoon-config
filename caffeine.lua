caffeine = hs.menubar.new()
icons = os.getenv("HOME") .. "/.hammerspoon/icons/"
iconSize = {h = 20, w = 20}

iconOn = hs.image.imageFromPath(icons .. "coffee-on.png"):setSize(iconSize)
iconOff = hs.image.imageFromPath(icons .. "coffee-off.png"):setSize(iconSize)

function setCaffeineDisplay(state)
    if state then
        caffeine:setIcon(iconOn)
        caffeine:setTooltip("Computer is staying awake")
    else
        caffeine:setIcon(iconOff)
        caffeine:setTooltip("Computer will go to sleep if there is no activity")
    end
end

function caffeineClicked(keys)
    setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
    caffeine:setClickCallback(caffeineClicked)
    setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end

return caffeine
