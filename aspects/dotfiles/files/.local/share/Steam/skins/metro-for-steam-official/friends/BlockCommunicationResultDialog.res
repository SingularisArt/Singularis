"friends/BlockCommunicationResultDialog.res"
{
	"BlockCommunicationResultDialog"
	{
		"ControlName"		"SimpleDialog"
		"fieldName"		"BlockCommunicationResultDialog"
		"xpos"		"979"
		"ypos"		"454"
		"wide"		"400"
		"tall"		"200"
		"AutoResize"		"0"
		"PinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"		"0"
		"paintbackground"		"1"
		"settitlebarvisible"		"1"
		"title"		"#Friends_BlockCommunicationWarning_Title"
	}
	"OKButton"
	{
		"ControlName"		"Button"
		"fieldName"		"ContinueButton"
		"xpos"		"27"
		"ypos"		"150"
		"wide"		"120"
		"tall"		"24"
		"AutoResize"		"0"
		"PinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"		"0"
		"paintbackground"		"1"
		"labelText"		"#vgui_ok"
		"textAlignment"		"west"
		"wrap"		"0"
		"Command"		"close"
		"Default"		"1"
	}
	"Label3"
	{
		"ControlName"		"Label"
		"fieldName"		"Label3"
		"xpos"		"28"
		"ypos"		"32"
		"wide"		"320"
		"tall"		"100"
		"AutoResize"		"0"
		"PinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"		"0"
		"paintbackground"		"1"
		"labelText"		"#Friends_BlockCommunicationResult"
		"textAlignment"		"north-west"
		"wrap"		"1"
	}
	"Label4"
	{
		"ControlName"		"URLLabel"
		"fieldName"		"Label4"
		"xpos"		"28"
		"ypos"		"100"
		"wide"		"320"
		"tall"		"24"
		"AutoResize"		"0"
		"PinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"		"0"
		"paintbackground"		"1"
		"labelText"		"#Friends_BlockCommunicationResult_YourBlockedList"
		"URLText"		"steam://url/BlockedPlayers"
		"textAlignment"		"north-west"
		"wrap"		"1"
	}
	layout
	{
		place { control="frame_minimize,frame_maximize,frame_close" align=right width=40 height=40 margin-right=1 }
		place { control="frame_captiongrip" width=max height=54 }

		place { control="Label3" margin=16 y=40 width=max }
		
		//Bottom
		region { name=bottom align=bottom height=44 margin=8 }
		place { control="Label4" region=bottom y=4 x=8 }
		place {	control="ContinueButton" region=bottom align=right spacing=8 height=28 width=84 }
	}
}
