#!/bin/sh

if [[ ! -d "$HOME/.tmux" ]]; then
  info "installing tmux plugins"
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
rm -rf $HOME/.tmux.conf

cat <<EOF >$HOME/.tmux.conf
# =====================================
# General settings
# =====================================

set -g default-terminal "xterm-256color"
set-option -ga terminal-overrides ",xterm-256color:Tc"

# Enable mouse
set -g mouse on

# Start index of 1
set -g base-index 1
set -g base-index 1
setw -g pane-base-index 1



# =====================================
# Key bindings
# =====================================

# Split panes
bind-key h split-window -h
bind-key v split-window -v

# Kill pane/window
bind-key k kill-pane
bind-key K kill-window

# Reload tmux configuration
bind r source-file ~/.tmux.conf \; display "Reloaded!"



# =====================================
# Variables     
# =====================================

# theme colors
status_bg="#21242b"
primary="#51afef"
highlight="#44b9b1"
color_primary="#2257A0"
color_secondary="#51afef"
color_info="colour39"
color_dark="colour232"
color_light="#bfbfbf"
color_success="#99bb66"
color_warning="#ECBE7B"
color_error="#ff6655"

# symbols
separator_powerline_left=""
separator_powerline_right=""
symbol_cpu=""
symbol_mem=""


# =====================================
# Appearence and status bar
# =====================================

# General status bar settings
set -g status-interval 10
set -g status-justify left
set -g status-right-length 100

set -g @sysstat_cpu_color_low "$color_success"

# status line style
set -g status-style "bg=$status_bg,fg=$color_light"

# custom plugins show
set -g @sysstat_cpu_view_tmpl '#[fg=#{cpu.color}]#[bg=#{cpu.color},fg=#{status_bg}] #{symbol_cpu} #{cpu.pused}'
set -g @sysstat_mem_view_tmpl '#[fg=#{mem.color}]#[bg=#{mem.color},fg=#{status_bg}] #{symbol_mem} #{mem.pfree}'

CPU="#{sysstat_cpu}"
MEM="#{sysstat_mem}"
BATTERY="#{battery_color_fg}#{battery_icon_charge}"
DATE_TIME="#[fg=$color_light]$separator_powerline_right#[bg=$color_light,fg=$color_dark]  %m-%d  %H:%M"

set -g status-left "#[bg=$color_primary,fg=$color_light]  #[bg=$status_bg,fg=$color_primary]$separator_powerline_left"
set -g status-right "${DATE_TIME} ${CPU} ${MEM} ${BATTERY}"

setw -g window-status-format "#[bold] #W "
setw -g window-status-current-format "#[bg=$color_secondary,fg=$status_bg]$separator_powerline_left#[bg=$color_secondary,fg=$color_light,bold] #W #[bg=$status_bg,fg=$color_secondary]$separator_powerline_left"
set -g window-status-separator "#[fg=$color_secondary,bg=$status_bg,bold]"



# =====================================
# Plugins
# =====================================

set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-battery'

set -g @plugin 'samoshkin/tmux-plugin-sysstat'

run -b '~/.tmux/plugins/tpm/tpm'
EOF

tmux source ~/.tmux.conf
