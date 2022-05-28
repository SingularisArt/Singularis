#!/usr/bin/env bash


cat <<EOF | xmenu | sh &
 Applications
	 Firefox										firefox
	 Terminal									xfce4-terminal
	 Files											nautilus
	 School
		 Notes										zathura ~/Documents/notes/current-course/master.pdf
	 Utilities
		 Calculator (TUI)				xfce4-terminal -e "qalc"
		 Calculator (GUI)				qalculate-gtk
		 Calendar								xfce4-terminal -e "calcurse"
		 Color Picker						gpick
		 Map (TUI)								xfce4-terminal -e "mapscii"
		Ranger										xfce4-terminal -e "ranger"
		Zathura										zathura
		 Theming
			lxappearance						lxappearance
			GTK         						oomox-gui
			Qt        							qt5ct --style gtk2
			WPGTK										wpg
		 Monitors
			Ytop										xfce4-terminal -e ytop
			Bashtop									xfce4-terminal -e bashtop
			Glances									xfce4-terminal -e glances
			Disk Usage	(AUI)				baobab
			Disk Usage	(TUI)				xfce4-terminal -e ncdu
			IO											xfce4-terminal -e iotop
			Kernel									xfce4-terminal -e kmon
			Nvidia GPU							xfce4-terminal -e nvtop
			Power										xfce4-terminal -e powertop
			DNS											xfce4-terminal -e powertop
			Network Usage         	xfce4-terminal -e jnettop
			Network Load        		xfce4-terminal -e nload
			Bandwidth		      			xfce4-terminal -e bmon
	 System
		 Fonts										gucharmap
		 Kill Window							xkill
		 Screen Recording				simplescreenrecorder
		 Screenshot
			All											scrot $HOME/Photos/screenshots/screenshot.png
			Current Window					scrot -ubz $HOME/Photos/screenshots/screenshot.png
			Select Window						scrot -sbz $HOME/Photos/screenshots/screenshot.png
		 Entertainment
			 Media
				 RSS									xfce4-terminal -e "newsboat"
				 Reddit							xfce4-terminal -e "tuir"
				 Music								xfce4-terminal -e "ncmpcpp"
				Soulseek							xfce4-terminal -e "nicotine"
			 Games
				 Steam								steam
				Itch									itch
				Lutris								lutris
				Tetris								tetris
				Solitaire							ttysolitaire
				Battleship						bs
				Minecraft							minecraft-launcher
				Dopewars							dopewars
		 Misc
			Cava										xfce4-terminal -e "cava"
			Pipes   								xfce4-terminal -e "pipes -p 4"
			Rain   									xfce4-terminal -e "rain"
			Cmatrix									xfce4-terminal -e "cmatrix"
			Asciiquarium						xfce4-terminal -e "asciiquarium"
			Bonsai   								xfce4-terminal -e "bonsai -l -i -T"
	 Science
		 Astronomy
			Celestia								celestia
		 Biology
			Pymol										pymol
		 Chemistry
			Ptable									xfce4-terminal -e "python3.6 ~/Singularis/vendor/pTable/ptable.py"
			Chemtool								chemtool
		 Math
			Desmos									desmos
			Geogebra								geogebra
		Anki											anki
	 Development
		 IDEs
			Neovim									xfce4-terminal -e "nvim"
		bitwise										bitwise

 Configs
	 System
		 Sound										pavucontrol
		 .Xprofile								xfce4-terminal -e "nvim $HOME/.xprofile"
		 Start Menu							xfce4-terminal -e "nvim $HOME/Singularis/local/scripts/xmenu-script"
		 Notifications						xfce4-terminal -e "nvim $HOME/.config/dunst/dunstrc"
		Window Managers
			 DWM										xfce4-terminal -e "nvim $HOME/.config/dwm/dwm-config/config.h"
			 i3										xfce4-terminal -e "nvim $HOME/.config/i3/config"
			 Awesome								xfce4-terminal -e "nvim $HOME/.config/awesome/rc.lua"
		 Shell
			Zsh
				Main									xfce4-terminal -e "nvim $HOME/.config/zsh/.zshrc"
				Functions							xfce4-terminal -e "nvim $HOME/.config/zsh/functions.zsh"
				Aliases								xfce4-terminal -e "nvim $HOME/.config/zsh/aliases.zsh"
				Color									xfce4-terminal -e "nvim $HOME/.config/zsh/color.zsh"
				Prompt								xfce4-terminal -e "nvim $HOME/.config/zsh/prompt.zsh"
				Exports								xfce4-terminal -e "nvim $HOME/.config/zsh/exports.zsh"
				Options								xfce4-terminal -e "nvim $HOME/.config/zsh/options.zsh"
				Vim-Mode							xfce4-terminal -e "nvim $HOME/.config/zsh/vim-mode.zsh"
		 Rofi
			config									xfce4-terminal -e "nvim $HOME/.config/rofi/config.rasi"
	 User
		Ranger										xfce4-terminal -e "nvim $HOME/.config/ranger/rc.conf"
		Newsboat									xfce4-terminal -e "nvim $HOME/.config/newsboat/config"
		Ncmpcpp										xfce4-terminal -e "nvim $HOME/.config/ncmpcpp/config"
		Zathura										xfce4-terminal -e "nvim $HOME/.config/zathura/zathurarc"
		Awesome										xfce4-terminal -e "nvim $HOME/.config/awesome/rc.lua"
		Neofetch									xfce4-terminal -e "nvim $HOME/.config/neofetch/config.conf"
		Htop											xfce4-terminal -e "nvim $HOME/.config/htop/htoprc"
		Dwm
			Dwm											xfce4-terminal -e "nvim $HOME/.config/dwm/dwm-config/config.h"
			Dmenu										xfce4-terminal -e "nvim $HOME/.config/dwm/dmenu/config.h"
			Statusbar								xfce4-terminal -e "nvim $HOME/.config/dwm/dwm-statusbar/dwm-iconbar"
		NeoMutt
			NeoMuttrc								xfce4-terminal -e "nvim $HOME/.muttrc"
			Colors									xfce4-terminal -e "nvim $HOME/.config/mutt/colors.mutt"
			Settings								xfce4-terminal -e "nvim $HOME/.config/mutt/settings.mutt"
			Mappings								xfce4-terminal -e "nvim $HOME/.config/mutt/bindings.mutt"
			Mailcap									xfce4-terminal -e "nvim $HOME/.config/mutt/mailcap"
		NeoVim
			Main										xfce4-terminal -e "nvim $HOME/.config/nvim/init.vim"
			Settings								xfce4-terminal -e "nvim $HOME/.config/nvim/lua/core/settings.lua"
			Lsp 										xfce4-terminal -e "nvim $HOME/.config/nvim/lua/core/lsp.lua"
			Mappings								xfce4-terminal -e "nvim $HOME/.config/nvim/lua/core/keymappings.lua"
			Plugin-Settings					xfce4-terminal -e "nvim $HOME/.config/nvim/lua/plugin-configs/"
			Plugins									xfce4-terminal -e "nvim $HOME/.config/nvim/lua/core/plugins.lua"
			UltiSnips								xfce4-terminal -e "nvim $HOME/.config/nvim/UltiSnips"

 System
	 Shutdown									poweroff
	 Reboot										reboot
EOF
