function getChromeTabs()
  ok, result = hs.osascript.applescript([[
    on toString(theList)
      set saveTID to text item delimiters
      set text item delimiters to "₪"
      set Final to theList as text
      set text item delimiters to saveTID
      return Final
    end

    set allTabs to {}
    tell application "Google Chrome"
      repeat with w in (windows)
        set j to 0
        repeat with t in (tabs of w)
          set j to j + 1
          copy title of t to the end of allTabs
        end repeat
      end repeat
    end tell
    
    toString(allTabs)
  ]])
  return result
end

function focusChromeTab(tab)
  hs.osascript.applescript('tell application "Google Chrome" to set (active tab index of (first window)) to ' .. tab)
  hs.osascript.applescript('tell application "Google Chrome" to activate')
end

local function csplit(str,sep)
  local ret={}
  local n=1
  for w in str:gmatch("([^"..sep.."]*)") do
    if w ~= '' then
     ret[n] = ret[n] or w -- only set once (so the blank after a string is ignored)
      n = n + 1
     end -- step forwards on a blank but not a string
  end
  return ret
end

local seperator = "₪"

function parseTabs()
  local choices = {}
  for key, tab in pairs(csplit(getChromeTabs(), seperator))
  do
    if tab ~= '' then
      table.insert(choices, {
        text=tab,
        index=key
      })
    end
  end
  return choices
end

-- Create the chooser.
-- On selection, copy the emoji and type it into the focused application.
local chooser = hs.chooser.new(function(choice)
  -- if not choice then focusLastFocused(); return end
  focusChromeTab(choice['index'])
end)

function clamp(num, min, max)
  if (num < min) then return min end
  if (num > max) then return max end
  return num
end

chooser:rows(5)
chooser:bgDark(true)
chooser:searchSubText(true)

function tableLength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function toggle()
  if (chooser:isVisible() == true) then
      chooser:hide()
  else
      local tabs = parseTabs()
      chooser:choices(tabs)
      chooser:rows(clamp(tableLength(tabs), 0, 10))
      chooser:show()
  end
end

return toggle
