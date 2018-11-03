function reloadConfig(files)
	doReload = false
	for _, file in pairs(files) do
		if file:sub(-4) == ".lua" then
			doReload = true
		end
	end
	if doReload then
		hs.reload()
	end
end

configWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show(
	"Hammerspoon Config Reloaded ",
	{
		textStyle = {
			font = {name = "Helvetica", size = 50},
			color = {hex = "#fff", alpha = .95},
			paragraphStyle = {
				alignment = "center"
			}
		},
		fillColor = {hex = "#000", alpha = .65},
		strokeColor = {hex = "#fff", alpha = .65},
		radius = 10
	}
)

return configWatcher
