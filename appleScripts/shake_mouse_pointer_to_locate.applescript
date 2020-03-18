
tell application "System Preferences"
	set current pane to pane "com.apple.preference.trackpad"
	activate
end tell

tell application "System Events"
	tell process "System Preferences"
		repeat while not (exists of radio button "Scroll & Zoom" of tab group 1 of window "Trackpad")
			delay 1.0E-3
		end repeat
		click radio button "Scroll & Zoom" of tab group 1 of window "Trackpad"
		click checkbox 1 of tab group 1 of window "Trackpad"
	end tell
end tell




tell application "System Preferences"
	reveal anchor "Seeing_Display" of pane id "com.apple.preference.universalaccess"
	activate
end tell

tell application "System Events"
	tell application process "System Preferences"
		repeat while not (exists of radio button "Cursor" of tab group 1 of group 1 of window "Accessibility")
			delay 1.0E-3
		end repeat
		click radio button "Cursor" of tab group 1 of group 1 of window "Accessibility"
		click checkbox "Shake mouse pointer to locate" of tab group 1 of group 1 of window "Accessibility"
	end tell
end tell



(*
tell application "System Preferences"
	reveal anchor "Seeing_Display" of pane id "com.apple.preference.universalaccess"
	activate
end tell

tell application "System Events" to tell application process "System Preferences"
	click radio button "Cursor" of tab group 1 of group 1 of window "Accessibility"
	
	click checkbox "Shake mouse pointer to locate" of tab group 1 of group 1 of window "Accessibility"
	
end tell


*)

(*
Download the old version of accessibiltiy inspector:
https://developer.apple.com/library/mac/samplecode/UIElementInspector/UIElementInspector.zip

Need to set it up with security rights so that it can view other applications. 
Then it tells you the breakdown of the window XML e.g:
<AXApplication: ÒSystem PreferencesÓ>
 <AXWindow: ÒAccessibilityÓ>
  <AXGroup>
   <AXTabGroup>
    <AXCheckBox: ÒShake mouse pointer to locateÓ>
*)
