-- Show Local / WAN IP Address.
-- Created 2017.10.04 by Jack-Daniyel Strong.
-- 2017.10.04 - Initial Configuration

-- (C)opyright 2008-2017 J-D Strong Consulting, Inc.

-- Variables, but you shouldn't need to modify these...
property theLocalIP : ""
property theWANIP : ""
property MyTitle : "Show Local / WAN IP Address"

-- Start the script (double click)
on run
	
	my main()
end run

-- Let's get something done!
on main()
	try
		getLocalIP()
		getWANIP()
		
		my DisplayInfoMsg("The local IP is: " & theLocalIP & "
The WAN IP is: " & theWANIP)
		
	on error ErrorMsg number ErrorNum
		my DisplayErrorMsg(ErrorMsg, ErrorNum)
	end try
end main

-- Let's get the local IP & save it to a global property
on getLocalIP()
	try
		set theIP to IPv4 address of (get system info)
		set theLocalIP to the last word of theIP
	on error
		set theLocalIP to "Can't get Local IP"
	end try
end getLocalIP

-- Let's get the WAN IP & save it to a global property
on getWANIP()
	try
		set theIP to (do shell script "dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | awk -F'\"' '{ print $2}'")
		
		set theWANIP to the last word of theIP
	on error
		set theWANIP to "Can't get Local IP"
	end try
end getWANIP

-- Display information to the user:
on DisplayInfoMsg(DisplayInfo)
	tell me
		activate
		display dialog DisplayInfo buttons {"OK"} default button 1 with icon note with title MyTitle
	end tell
end DisplayInfoMsg


-- Display an error message to the user:
on DisplayErrorMsg(ErrorMsg, ErrorNum)
	set Msg to "Sorry, an error occured:" & return & return & ErrorMsg & " (" & ErrorNum & ")"
	tell me
		activate
		display dialog Msg buttons {"OK"} default button 1 with icon stop with title MyTitle
	end tell
end DisplayErrorMsg
