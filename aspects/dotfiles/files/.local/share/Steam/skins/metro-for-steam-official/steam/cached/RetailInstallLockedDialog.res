"steam/cached/RetailInstallLockedDialog.res"
{
	"RetailInstallLockedDialog"
	{
		"ControlName"		"SimpleDialog"
		"fieldName"		"RetailInstallLockedDialog"
		"xpos"		"604"
		"ypos"		"465"
		"wide"		"420"
		"tall"		"242"
		"AutoResize"		"0"
		"PinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"		"0"
		"paintbackground"		"1"
		"settitlebarvisible"		"1"
		"title"		"#Steam_RetailInstallLocked_Title"
	}
	"Label1"
	{
		"ControlName"		"Label"
		"fieldName"		"Label1"
		"xpos"		"12"
		"ypos"		"50"
		"wide"		"390"
		"tall"		"92"
		"AutoResize"		"0"
		"PinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"		"0"
		"paintbackground"		"1"
		"labelText"		"#Steam_RetailInstallLocked_Info"
		"textAlignment"		"north-west"
		"wrap"		"1"
	}
	"Button1"
	{
		"ControlName"		"Button"
		"fieldName"		"Button1"
		"xpos"		"311"
		"ypos"		"199"
		"wide"		"84"
		"tall"		"24"
		"AutoResize"		"0"
		"PinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"		"1"
		"paintbackground"		"1"
		"labelText"		"#vgui_ok"
		"textAlignment"		"west"
		"wrap"		"0"
		"Command"		"Close"
		"Default"		"1"
	}
	"WebLinkURL"
	{
		"ControlName"		"URLLabel"
		"fieldName"		"WebLinkURL"
		"xpos"		"13"
		"ypos"		"155"
		"wide"		"390"
		"tall"		"40"
		"AutoResize"		"0"
		"PinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"		"0"
		"paintbackground"		"1"
		"labelText"		"#Steam_RetailInstallLocked_LinkText"
		"textAlignment"		"north-west"
		"wrap"		"0"
		"URLText"		"http://www.steampowered.com/index.php?area=news"
	}
	layout
	{
		place { control="frame_minimize,frame_maximize,frame_close" align=right width=40 height=40 margin-right=1 }
		place { control="frame_captiongrip" height=40 width=max }

		//Footer
		region { name="bottom" align=bottom height=44 margin=8 }
		place { control="Button1" region=bottom align=right width=84 height=28 spacing=8 }
	}
}
