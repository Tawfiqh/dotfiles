

-- Hides the Menu up top
tell application "System Preferences"
	
	--open General Settings
	activate
	set the current pane to pane id "com.apple.preference.general"
	try
		
		--wait for screen to boot
		repeat until window "General" exists
			delay 0.2
		end repeat
	on error error_message
		get error_message
	end try
end tell


--click the appropriate check box
tell application "System Events"
	set theCheckbox to checkbox "Automatically hide and show the menu bar" of window "General" of application process "System Preferences" of application "System Events"
	tell theCheckbox
		if not (its value as boolean) then click theCheckbox
	end tell
end tell
tell application "System Events" to set the autohide of the dock preferences to true
