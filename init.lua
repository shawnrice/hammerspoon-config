--
-- Main entrance file for the Hammerspoon configuration. This file should import modules and then
-- bind keys.
--
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

spoon.SpoonInstall.repos.zzspoons = {
  url = "https://github.com/zzamboni/zzSpoons",
  desc = "zzamboni's spoon repository"
}

Install = spoon.SpoonInstall

textClipHistory =
  Install:andUse(
  "TextClipboardHistory",
  {
    config = {
      show_in_menubar = false
    },
    hotkeys = {
      toggle_clipboard = {{"cmd", "shift"}, "v"}
    },
    start = true
  }
)

-- Load the configuration watcher so we can hot reload the hammerspoon configs
configWatcher = require("configWatcher")

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

-- hs.loadSpoon('HeadphoneAutoPause')
-- hs.loadSpoon('KSheet')
-- local headphoneAutoPause = require('./Spoons/HeadphoneAutoPause.spoon/HeadphoneAutoPause.spoon/init.lua')
-- headphoneAutoPause.start()

print("psu serial" .. hs.battery.psuSerial())
print(hs.battery.timeRemaining())

-- Todo: add...
-- http://www.hammerspoon.org/Spoons/WifiNotifier.html or http://www.hammerspoon.org/Spoons/WiFiTransitions.html
-- http://www.hammerspoon.org/Spoons/Seal.html
-- http://www.hammerspoon.org/Spoons/Seal.plugins.useractions.html
-- Has weather and gmail notifications https://github.com/andrewhampton/dotfiles/tree/master/hammerspoon/
-- Sliding panels: https://github.com/asmagill/hammerspoon-config/blob/master/_Spoons/SlidingPanels.spoon/init.lua
