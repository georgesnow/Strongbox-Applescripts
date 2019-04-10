on menu_click(mList)
	local appName, topMenu, r
	
	-- Validate our input
	if mList's length < 3 then error "Menu list is not long enough"
	
	-- Set these variables for clarity and brevity later on
	set {appName, topMenu} to (items 1 through 2 of mList)
	set r to (items 3 through (mList's length) of mList)
	
	-- WHY NOT DO SOMETHING LIKE THIS FIRST?
	tell application appName to activate
	
	-- This overly-long line calls the menu_recurse function with
	-- two arguments: r, and a reference to the top-level menu
	tell application "System Events" to my menu_click_recurse(r, ((process appName)'s Â
		(menu bar 1)'s (menu bar item topMenu)'s (menu topMenu)))
end menu_click


on menu_click_recurse(mList, parentObject)
	local f, r
	
	-- `f` = first item, `r` = rest of items
	set f to item 1 of mList
	if mList's length > 1 then set r to (items 2 through (mList's length) of mList)
	
	-- either actually click the menu item, or recurse again
	tell application "System Events"
		if mList's length is 1 then
			click parentObject's menu item f
		else
			my menu_click_recurse(r, (parentObject's (menu item f)'s (menu f)))
		end if
	end tell
end menu_click_recurse

--menu_click({"Script Editor", "File", "New"})




if application "Strongbox" is not frontmost then
	tell application "System Events" to set visible of application process "Strongbox" to true
	menu_click({"Strongbox", "Edit", "FindÉ"})
	
else if application "Strongbox" is frontmost then
	tell application "System Events" to set visible of application process "Strongbox" to false
	
end if






(*end tell*)
