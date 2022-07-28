static const Rule rules[] = {
	// class      instance      title    	        tags mask     isfloating   isterminal  noswallow  monitor
	{ "Gimp",       NULL,         NULL,             1,            0,          0,          0,          -1 },
	{ "Gimp",       NULL,         NULL,             1 << 8,       0,          0,          0,          -1 },
	{ TERMCLASS,    NULL,         NULL,       	    0,            0,          1,          0,           0 },
	{ NULL,         NULL,         "Event Tester",   0,            0,          0,          0,           1 },
	{ NULL,         "spterm",     NULL,       	    SPTAG(0),     1,          1,          0,           0 },
	{ NULL,         "key_pdf",    NULL,       	    0,			      1,          1,          1,           0 },
};

static Key keys[] = {
  STACKKEYS(MODKEY,                          focus)
  STACKKEYS(MODKEY|ShiftMask,                push)
  TAGKEYS(XK_1,	0)
  TAGKEYS(XK_2,	1)
  TAGKEYS(XK_3,	2)
  TAGKEYS(XK_4,	3)
  TAGKEYS(XK_5,	4)
  TAGKEYS(XK_6,	5)
  TAGKEYS(XK_7,	6)
  TAGKEYS(XK_8,	7)
  TAGKEYS(XK_9,	8)
  // Changing layouts
  { MODKEY|AltMask,							        XK_0,						setlayout,			{.v = &layouts[0]} },
  { MODKEY|AltMask,							        XK_1,						setlayout,			{.v = &layouts[1]} },
  { MODKEY|AltMask,							        XK_2,						setlayout,			{.v = &layouts[2]} },
  { MODKEY|AltMask,							        XK_3,						setlayout,			{.v = &layouts[3]} },
  { MODKEY|AltMask,							        XK_4,						setlayout,			{.v = &layouts[4]} },
  { MODKEY|AltMask,							        XK_5,						setlayout,			{.v = &layouts[5]} },
  { MODKEY|AltMask,							        XK_6,						setlayout,			{.v = &layouts[6]} },
  { MODKEY|AltMask,							        XK_7,						setlayout,			{.v = &layouts[7]} },
  { MODKEY|AltMask,							        XK_8,						setlayout,			{.v = &layouts[8]} },

  // DWM specific keybindings
  { MODKEY,							                XK_Tab,						view,				{0} },
  { MODKEY,							                XK_o,						incnmaster,			{.i = +1 } },
  { MODKEY|ShiftMask,		                        XK_o,						incnmaster,			{.i = -1 } },
  { MODKEY,							                XK_q,						killclient,			{0} },
  { MODKEY|ShiftMask,                               XK_q,						spawn,				SHCMD("kill -HUP $(pidof -s dwm) && xdotool key Super_L") },
  { MODKEY|ShiftMask|AltMask,                       XK_q,						quit,				{0} },
  { MODKEY|AltMask,                                 XK_b,						togglebar,			{0} },
  { MODKEY|ShiftMask|AltMask,                       XK_b,						spawn,				SHCMD("killall -q dwmblocks; dwmblocks &") },
  { MODKEY,							                XK_a,						togglegaps,			{0} },
  { MODKEY,							                XK_z,						incrgaps,			{.i = +3 } },
  { MODKEY,							                XK_x,						incrgaps,			{.i = -3 } },
  { MODKEY,							                XK_s,						togglesticky,		{0} },
  { MODKEY,							                XK_f,						togglefullscr,	    {0} },
  { MODKEY,							                XK_h,						setmfact,			{.f = -0.05} },
  { MODKEY,							                XK_l,						setmfact,      	    {.f = +0.05} },
  { MODKEY|ShiftMask,		                        XK_semicolon,			    shifttag,			{ .i = 1 } },
  { MODKEY,							                XK_Left,					focusmon,			{.i = -1 } },
  { MODKEY,							                XK_Right,					focusmon,			{.i = +1 } },
  { MODKEY|ShiftMask,		                        XK_Left,					tagmon,				{.i = -1 } },
  { MODKEY|ShiftMask,		                        XK_Right,					tagmon,				{.i = +1 } },
  { MODKEY,							                XK_space,					zoom,				{0} },
  { MODKEY|ShiftMask,		                        XK_space,					togglefloating,	    {0} },
};

