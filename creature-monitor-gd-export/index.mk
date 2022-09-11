# Right, so, concerns:
# + we DON'T want to force people to do a build for dev.
# + we kinda need to force it if someone is doing a full release (deal with it)
# + rel expects all dependencies to be actual files
# + we want up-to-date licensing information for Godot
# Therefore:
# + phony target for the PCK (but only the PCK, so it doesn't build 3 times over)

rel: creature-monitor-gd-export/creamoni.pck creature-monitor-gd-export/creamoni.x86_64 creature-monitor-gd-export/creamoni.exe

.PHONY: creature-monitor-gd-export/creamoni.pck
creature-monitor-gd-export/creamoni.pck creature-monitor-gd-export/creamoni.x86_64 creature-monitor-gd-export/creamoni.exe:
	godot --path creature-monitor-gd --export "Linux/X11" ../creature-monitor-gd-export/creamoni.x86_64
	godot --path creature-monitor-gd --export "Windows Desktop" ../creature-monitor-gd-export/creamoni.exe
