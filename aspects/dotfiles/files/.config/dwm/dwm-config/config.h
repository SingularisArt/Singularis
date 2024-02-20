/* See LICENSE file for copyright and license details. */
#include "tcl.c"

/* Constants */
#define TERMINAL "xfce4-terminal"
#define TERMCLASS "St"
#define BROWSER "google-chrome-stable"
#define FILEBROWSER "nautilus"
#define AltMask Mod1Mask
#define PDF_VIEWER "zathura"
#define CURRENTCOURSE "~/Documents/notes/current-course"
#define SCHOOL_PATH "~/Singularis/local/school"
#define THIRD_PARTY "~/Singularis/third-party-tools"

// Appearance
static const unsigned int borderpx  = 3;    // border pixel of windows
static const unsigned int snap      = 25;   // snap pixel
static const unsigned int gappih    = 20;   // horiz inner gap between windows
static const unsigned int gappiv    = 10;   // vert inner gap between windows
static const unsigned int gappoh    = 10;   // horiz outer gap between windows and screen edge
static const unsigned int gappov    = 30;   // vert outer gap between windows and screen edge
static const int swallowfloating    = 0;    // 1 means swallow floating windows by default
static const int smartgaps          = 0;    // 1 means no outer gap when there is only one window
static const int showbar            = 1;    // 0 means no bar
static const int topbar             = 1;    // 0 means bottom bar
static const int user_bh			      = 36;		// 0 means normal bar height, >1 means user bar height

//static const char *fonts[]          = { "Noto Color Emoji:size=10",
static const char *fonts[]          = { "monospace:size=8",
                                        "fontawesome:size=8",
                                        "JoyPixels:pixelsize=8" };
static const char dmenufont[]			  = "monospace:size=12";

#include "/home/hashem/.cache/wal/colors-wal-dwm.h"

typedef struct {
	const char *name;
	const void *cmd;
} Sp;
const char *spcmd1[] = { TERMINAL, "-n", "spterm", "-g", "120x34", NULL };
const char *spcmd2[] = { TERMINAL, "-n", "spcalc", "-f", "monospace:size=16", "-g", "80x80", "-e", "bc", "-lq", NULL };
static Sp scratchpads[] = {
	/* name          cmd  */
	{"spterm",      spcmd1},
	{"spcalc",      spcmd2},
};

/* tagging */
static const char *tags[] = { "", "", "", "", "", "", "", "", "" };

/* layout(s) */
static float mfact     = 0.55;
static int nmaster     = 1;
static int resizehints = 0;
#define FORCE_VSPLIT 1

#include "vanitygaps.c"

static const Layout layouts[] = {
	/* symbol     arrange function */
 	{ "[]=",	      tile },			              // Default: Master on left, slaves on right
	{ "TTT",	      bstack },		              // Master on top, slaves on bottom
	{ "H[]",	      deck },			              // Master on left, slaves in monocle-like mode on right
	{ "[@]",	      spiral },		              // Fibonacci spiral
	{ "[\\]",	      dwindle },		            // Decreasing in size right and leftward
	{ "|M|",	      centeredmaster },		      // Master in middle, slaves on sides
	{ ">M>",	      centeredfloatingmaster },	// Same but master floats
	{ "|||",        tcl },                    // Column Layout
  { "><>",	      NULL },			              // no layout function means floating behavior
	{ NULL,		      NULL },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },
#define STACKKEYS(MOD,ACTION) \
	{ MOD,	XK_j,	ACTION##stack,	{.i = INC(+1) } }, \
	{ MOD,	XK_k,	ACTION##stack,	{.i = INC(-1) } }, \
	{ MOD,  XK_v,   ACTION##stack,  {.i = 0 } }, \

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char *termcmd[]  = { TERMINAL, NULL };

// Xresources preferences to load at startup
ResourcePref resources[] = {
	{ "color0",						STRING,		&norm_border },
	{ "color8",						STRING,		&sel_border },
	{ "color0",						STRING,		&norm_bg },
	{ "color4",						STRING,		&norm_fg },
	{ "color0",						STRING,		&sel_fg },
	{ "color4",						STRING,		&sel_bg },
	{ "borderpx",					INTEGER,	&borderpx },
	{ "snap",							INTEGER,	&snap },
	{ "showbar",					INTEGER,	&showbar },
	{ "topbar",						INTEGER,	&topbar },
	{ "nmaster",					INTEGER,	&nmaster },
	{ "resizehints",			INTEGER,	&resizehints },
	{ "mfact",						FLOAT,		&mfact },
	{ "gappih",						INTEGER,	&gappih },
	{ "gappiv",						INTEGER,	&gappiv },
	{ "gappoh",						INTEGER,	&gappoh },
	{ "gappov",						INTEGER,	&gappov },
	{ "swallowfloating",	INTEGER,	&swallowfloating },
	{ "smartgaps",				INTEGER,	&smartgaps },
};

#include <X11/XF86keysym.h>
#include "shiftview.c"

#include "keys.h"

static Button buttons[] = {
#ifndef __OpenBSD__
  { ClkWinTitle,          0,              Button2,        zoom,           {0} },
  { ClkStatusText,        0,              Button1,        sigdwmblocks,   {.i = 1} },
  { ClkStatusText,        0,              Button2,        sigdwmblocks,   {.i = 2} },
  { ClkStatusText,        0,              Button3,        sigdwmblocks,   {.i = 3} },
  { ClkStatusText,        0,              Button4,        sigdwmblocks,   {.i = 4} },
  { ClkStatusText,        0,              Button5,        sigdwmblocks,   {.i = 5} },
  { ClkStatusText,        ShiftMask,      Button1,        sigdwmblocks,   {.i = 6} },
#endif
  { ClkStatusText,        ShiftMask,      Button3,        spawn,          SHCMD(TERMINAL " -e nvim ~/.local/src/dwmblocks/config.h") },
  { ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
  { ClkClientWin,         MODKEY,         Button2,        defaultgaps,	  {0} },
  { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
  { ClkClientWin,					MODKEY,					Button4,				incrgaps,	{.i = +1} },
  { ClkClientWin,					MODKEY,					Button5,				incrgaps,	{.i = -1} },
  { ClkTagBar,            0,              Button1,        view,           {0} },
  { ClkTagBar,            0,              Button3,        toggleview,     {0} },
  { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
  { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
  { ClkTagBar,						0,							Button4,				shiftview,			{.i = -1} },
  { ClkTagBar,						0,							Button5,				shiftview,			{.i = 1} },
  { ClkRootWin,						0,							Button2,				togglebar,			{0} },
};
