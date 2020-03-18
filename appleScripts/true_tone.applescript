
-- Hides the Menu up top
tell application "System Preferences"
	
	--open General Settings
	activate
	set the current pane to pane id "com.apple.preference.displays"
	try
		
		--wait for screen to boot
		repeat until window "Built-in Retina Display" exists
			delay 0.2
		end repeat
		
		tell application "System Events"
			
			set theCheckbox to checkbox "True Tone" of tab group 1 of window 1 of application process "System Preferences"
			click theCheckbox
			
		end tell
		
	on error error_message
		get error_message
	end try
end tell
