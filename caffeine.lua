caffeine = hs.menubar.new()
function setCaffeineDisplay(state)
    if state then
        local iconOn =
            hs.image.imageFromPath(os.getenv("HOME") .. "/.hammerspoon/icons/coffee-on.png"):setSize({h = 16, w = 16})
        caffeine:setIcon(iconOn)
        caffeine:setTooltip("Computer is staying awake")
    else
        local iconOff =
            hs.image.imageFromPath(os.getenv("HOME") .. "/.hammerspoon/icons/coffee-off.png"):setSize({h = 16, w = 16})
        caffeine:setIcon(iconOff)
        caffeine:setTooltip("Computer will go to sleep if there is no activity")
    end
end

function caffeineClicked(keys)
    -- print(hs.inspect(keys))
    setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end

-- caffeine:setMenu({
--     { title = 'This is a test' },
--     { title = '-' },
--     { title = 'Test 2' },
-- })

if caffeine then
    caffeine:setClickCallback(caffeineClicked)
    setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end

return caffeine
