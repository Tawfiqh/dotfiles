tell application "System Preferences"
	set current pane to pane "com.apple.preference.trackpad"
	activate
end tell

tell application "System Events"
	tell process "System Preferences"
		click radio button "Scroll & Zoom" of tab group 1 of window "Trackpad"
		click checkbox 1 of tab group 1 of window "Trackpad"
	end tell
end tell
