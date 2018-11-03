--
-- Main entrance file for the Hammerspoon configuration. This file should import modules and then
-- bind keys.
--

----------------------------------------------------------------------------------------------------
-- Setup
hs.logger.defaultLogLevel = "info"

-- Make the console dark
hs.console.darkMode(true)
if hs.console.darkMode() then
  hs.console.outputBackgroundColor {white = 0}
  hs.console.consoleCommandColor {white = 1}
  hs.console.consolePrintColor {white = 1}
  hs.console.alpha(1)
end

hyper = {"cmd", "alt", "ctrl"}
shiftHyper = {"cmd", "alt", "ctrl", "shift"}

hs.loadSpoon("SpoonInstall")
hs.loadSpoon("ModalMgr")

spoon.SpoonInstall.repos.zzspoons = {
  url = "https://github.com/zzamboni/zzSpoons",
  desc = "zzamboni's spoon repository"
}

Install = spoon.SpoonInstall
----------------------------------------------------------------------------------------------------

textClipHistory =
  Install:andUse(
  "TextClipboardHistory",
  {
    config = {
      show_in_menubar = false
    },
    hotkeys = {
      toggle_clipboard = {shiftHyper, "v"}
    },
    start = true
  }
)

-- Load the configuration watcher so we can hot reload the hammerspoon configs
configWatcher = require("configWatcher")

-- We can use a chooser to search chrome's tabs
chromeTabs = require("chromeTabs")
hs.hotkey.bind(shiftHyper, "T", chromeTabs)

-- Load the caffeine module
caffeine = require("caffeine")

-- Create an Alfred-like emoji picker
emojiChooser = require("emoji")
hs.hotkey.bind(shiftHyper, "E", emojiChooser)

-- Moves windows back onto the main window
local rescueWindows = require("rescueWindow")
hs.hotkey.bind(shiftHyper, "R", rescueWindows)

-- Use fn and keys for other arrows as well as mouse wheel
local keyScroll = require("keyScroll")
keyScroll:init()

-- Get this working:
-- source : https://github.com/jasonrudolph/ControlEscape.spoon#optional-a-more-useful-caps-lock-key
local controlEscape = require("controlEscape")
controlEscape:init()

hs.hotkey.bind(shiftHyper, "C", hs.toggleConsole)

-- hs.loadSpoon('HeadphoneAutoPause')
-- ksheet = hs.loadSpoon("KSheet")
-- hs.hotkey.bind(shiftHyper, "K", ksheet)
-- local headphoneAutoPause = require('./Spoons/HeadphoneAutoPause.spoon/HeadphoneAutoPause.spoon/init.lua')
-- headphoneAutoPause.start()

----------------------------------------------------------------------------------------------------
-- Show battery time remaining
function formatMinutes(minutes)
  suffix = (minutes < 0) and "until charged" or "until empty"
  minutes = math.abs(minutes)
  hours = math.floor(minutes / 60)
  minutes = math.floor(minutes % 60)
  return hours .. " hours and " .. minutes .. " minutes remaining " .. suffix
end

function showBattery()
  local time = hs.battery.timeRemaining()
  if (time == -1.0) then
    hs.alert("Battery: Calculating time remaining...")
  elseif (time == -2.0) then
    hs.alert("Battery: plugged in...")
  else
    hs.alert("Battery: " .. formatMinutes(time))
  end
end
hs.hotkey.bind(shiftHyper, "B", showBattery)
----------------------------------------------------------------------------------------------------

spoon.ModalMgr.supervisor:enter()

-- Todo: add...
-- http://www.hammerspoon.org/Spoons/WifiNotifier.html or http://www.hammerspoon.org/Spoons/WiFiTransitions.html
-- http://www.hammerspoon.org/Spoons/Seal.html
-- http://www.hammerspoon.org/Spoons/Seal.plugins.useractions.html
-- Has weather and gmail notifications https://github.com/andrewhampton/dotfiles/tree/master/hammerspoon/
-- Sliding panels: https://github.com/asmagill/hammerspoon-config/blob/master/_Spoons/SlidingPanels.spoon/init.lua
