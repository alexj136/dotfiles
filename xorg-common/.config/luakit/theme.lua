--------------------------
-- Default luakit theme --
--------------------------

local theme = {
    yellow  = "#b58900",
    orange  = "#cb4b16",
    red     = "#dc322f",
    magenta = "#d33682",
    violet  = "#6c71c4",
    blue    = "#268bd2",
    cyan    = "#2aa198",
    green   = "#859900",
   
    base03  = "#002b36",
    base02  = "#073642",
    base01  = "#586e75",
    base00  = "#657b83",
    base0   = "#839496",
    base1   = "#93a1a1",
    base2   = "#eee8d5",
    base3   = "#fdf6e3",
}

-- Default settings
theme.font = "Inconsolata 10"
theme.fg   = theme.base0
theme.bg   = theme.base03

-- Genaral colours
theme.success_fg = theme.green
theme.loaded_fg  = theme.yellow
theme.error_fg   = theme.base3
theme.error_bg   = theme.red

-- Warning colours
theme.warning_fg = theme.base3
theme.warning_bg = theme.red

-- Notification colours
theme.notif_fg = theme.yellow
theme.notif_bg = theme.base2

-- Menu colours
theme.menu_fg                   = theme.base0
theme.menu_bg                   = theme.base03
theme.menu_selected_fg          = theme.base1
theme.menu_selected_bg          = theme.base01
theme.menu_title_bg             = theme.base03
theme.menu_primary_title_fg     = theme.base1
theme.menu_secondary_title_fg   = theme.base2

-- Proxy manager
theme.proxy_active_menu_fg      = '#000'
theme.proxy_active_menu_bg      = '#FFF'
theme.proxy_inactive_menu_fg    = '#888'
theme.proxy_inactive_menu_bg    = '#FFF'

-- Statusbar specific
theme.sbar_fg         = theme.base3
theme.sbar_bg         = theme.base00

-- Downloadbar specific
theme.dbar_fg         = theme.base0
theme.dbar_bg         = theme.base03
theme.dbar_error_fg   = theme.red

-- Input bar specific
theme.ibar_fg           = theme.base0
theme.ibar_bg           = theme.base03

-- Tab label
theme.tab_fg            = theme.base0
theme.tab_bg            = theme.base03
theme.tab_ntheme        = theme.base3
theme.selected_fg       = theme.base3
theme.selected_bg       = theme.base00
theme.selected_ntheme   = theme.base3
theme.loading_fg        = theme.yellow
theme.loading_bg        = theme.base02

-- Trusted/untrusted ssl colours
theme.trust_fg          = theme.green
theme.notrust_fg        = theme.red

-- Indicator colors
theme.ind_padding  = { x = 1 }
theme.ind_colors   = { enabled = {  fg = theme.base3,
                                    bg = theme.green },
                       disabled = { fg = theme.base3,
                                    bg = theme.red }
}

return theme
-- vim: et:sw=4:ts=8:sts=4:tw=80
