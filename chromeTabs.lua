function implode(d, p)
  local newstr
  newstr = ""
  if (#p == 1) then
    return p[1]
  end
  for ii = 1, (#p - 1) do
    newstr = newstr .. p[ii] .. d
  end
  newstr = newstr .. p[#p]
  return newstr
end

function getChromeTabs()
  ok, result =
    hs.osascript.javascript(
    [[
      const { windows } = Application('Google Chrome');
      const out = [];
      
      for (let w = 0; w < windows.length; w++) {
        const win = windows[w];
        const { tabs } = win;
        for (let t = 0; t < tabs.length; t++) {
          const tab = win.tabs[t];
          const { title, url } = tab;
          
          out.push({
            window: w + 1,
            tab: t + 1,
            text: title(),
            subText: url(),
          });
        }
      }
      
      JSON.stringify(out);
  ]]
  )
  return result
end

function focusChromeTab(tab, window)
  local script = {
    'tell application "Google Chrome" to set (active tab index of window ' .. window .. ") to " .. tab,
    'tell application "Google Chrome"',
    "set index of window " .. window .. " to 1",
    "end tell",
    'tell application "System Events" to tell process "Google Chrome"',
    'perform action "AXRaise" of window 1',
    "set frontmost to true",
    "end tell",
    'tell application "Google Chrome" to activate'
  }
  hs.osascript.applescript(implode("\n", script))
end

function clamp(num, min, max)
  if (num < min) then
    return min
  end
  if (num > max) then
    return max
  end
  return num
end

function length(T)
  local count = 0
  for _ in pairs(T) do
    count = count + 1
  end
  return count
end

-- Create the chooser.
-- On selection, copy the emoji and type it into the focused application.
local chooser =
  hs.chooser.new(
  function(choice)
    if choice then
      -- if not choice then focusLastFocused(); return end
      focusChromeTab(choice["tab"], choice["window"])
    end
  end
)
chooser:bgDark(true)
chooser:searchSubText(true)

function toggle()
  if (chooser:isVisible() == true) then
    chooser:hide()
  else
    tabs = hs.json.decode(getChromeTabs())
    chooser:choices(tabs)
    chooser:rows(clamp(length(tabs), 0, 10))
    chooser:show()
  end
end

return toggle
