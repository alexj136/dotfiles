{-------------------------------------------------------------------------------
        ALEX'S XMONAD CONFIGURATION FILE
-------------------------------------------------------------------------------}
-- Required imports

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Actions.CycleWS
import XMonad.Util.Run
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile

import XMonad.Prompt
import XMonad.Prompt.Shell

import Graphics.X11.ExtraTypes.XF86

import System.Exit
import System.IO (stderr)
--import System.Process (runCommand)
import System.Directory (getHomeDirectory)

import qualified XMonad.StackSet               as W
import qualified XMonad.Actions.FlexibleResize as F
import qualified Data.Map                      as M

{-------------------------------------------------------------------------------
        COLOUR DEFINITIONS
-------------------------------------------------------------------------------}

data ColorKind = Background | Middle | Foreground | Highlight

molokaiColors :: ColorKind -> String
molokaiColors = \c -> case c of
    Background -> molokai_black
    Middle     -> molokai_lightgrey
    Foreground -> molokai_white
    Highlight  -> molokai_turquoise
molokai_black       = "#101010" :: String
molokai_darkgrey    = "#303030" :: String
molokai_lightgrey   = "#9999aa" :: String
molokai_white       = "#d0d0d0" :: String
molokai_darkgreen   = "#66aa11" :: String
molokai_lightgreen  = "#80ff00" :: String
molokai_darkblue    = "#30309b" :: String
molokai_lightblue   = "#3579a8" :: String
molokai_turquoise   = "#5f5fee" :: String
molokai_brightblue  = "#4eb4fa" :: String
molokai_darkpurple  = "#7e40a5" :: String
molokai_magenta     = "#960050" :: String
molokai_lightpurple = "#bb88dd" :: String
molokai_pink        = "#ff0090" :: String
molokai_peach       = "#ffba68" :: String
molokai_orange      = "#c47f2c" :: String

solarizedDarkColors :: ColorKind -> String
solarizedDarkColors = \c -> case c of
    Background -> solarized_darkest
    Middle     -> solarized_dark
    Foreground -> solarized_lighter
    Highlight  -> solarized_blue
solarizedLightColors :: ColorKind -> String
solarizedLightColors = \c -> case c of
    Background -> solarized_lightest
    Middle     -> solarized_darker
    Foreground -> solarized_light
    Highlight  -> solarized_yellow
solarized_yellow   = "#b58900" :: String
solarized_orange   = "#cb4b16" :: String
solarized_red      = "#dc322f" :: String
solarized_magenta  = "#d33682" :: String
solarized_violet   = "#6c71c4" :: String
solarized_blue     = "#268bd2" :: String
solarized_cyan     = "#2aa198" :: String
solarized_green    = "#859900" :: String
solarized_lightest = "#fdf6e3" :: String
solarized_lighter  = "#eee8d5" :: String
solarized_light    = "#93a1a1" :: String
solarized_lightish = "#839496" :: String
solarized_darkish  = "#657b83" :: String
solarized_dark     = "#586e75" :: String
solarized_darker   = "#073642" :: String
solarized_darkest  = "#002b36" :: String

{-------------------------------------------------------------------------------
        SIMPLE SETTINGS
-------------------------------------------------------------------------------}

myTerminal           = "xterm"
myBorderWidth        = 2
myColors             = solarizedLightColors
myModMask            = mod4Mask
myWorkspaces         = map show [1..9]
myFocusFollowsMouse  = True

{-------------------------------------------------------------------------------
        KEY BINDINGS. ADD, MODIFY OR REMOVE KEY BINDINGS HERE.
-------------------------------------------------------------------------------}

myKeys homeDir conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm              , xK_Return), spawn $ XMonad.terminal conf)
    , ((modm              , xK_t     ), spawn $ XMonad.terminal conf)

    -- launch chrome
    , ((modm              , xK_y     ), spawn "google-chrome-stable" )

    -- launch zathura
    , ((modm              , xK_u     ), spawn "zathura" )

    -- Run application launcher
    , ((modm              , xK_d     ), myShellPrompt myXPConfig)

    -- close focused window
    , ((modm .|. shiftMask, xK_q     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm              , xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm              , xK_n     ), refresh)

    -- Cycle non-empty workspaces with mod+tab or mod+shift+tab
    , ((modm              , xK_Tab   ), moveTo Next NonEmptyWS)
    , ((modm .|. shiftMask, xK_Tab   ), moveTo Prev NonEmptyWS)

    -- Move focus to the next window
    , ((modm              , xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm              , xK_k     ), windows W.focusUp)

    -- Move focus to the master window
    , ((modm              , xK_m     ), windows W.focusMaster)

    -- Swap the focused window and the master window
    , ((modm .|. shiftMask, xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown)

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp)

    -- Shrink/Expand the master area
    , ((modm              , xK_h     ), sendMessage Shrink)
    , ((modm              , xK_l     ), sendMessage Expand)

    -- Shrink/Expand child areas
    , ((modm .|. shiftMask, xK_h     ), sendMessage MirrorShrink)
    , ((modm .|. shiftMask, xK_l     ), sendMessage MirrorExpand)

    -- Push window back into tiling
    , ((modm              , xK_i     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_x     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm .|. shiftMask, xK_c     ), restart "xmonad" True)

    -- Volume keys - with dedicated buttons
    , ((0, xF86XK_AudioLowerVolume   ), spawn myAudioLowerCommand)
    , ((0, xF86XK_AudioRaiseVolume   ), spawn myAudioRaiseCommand)
    , ((0, xF86XK_AudioMute          ), spawn myAudioMuteCommand)

    -- Volume keys - with keyboard bindings
    , ((modm              , xK_minus ), spawn myAudioLowerCommand)
    , ((modm              , xK_equal ), spawn myAudioRaiseCommand)
    , ((modm              , xK_0     ), spawn myAudioMuteCommand)

    -- ThinkVantage button launches chrome
    , ((0, 0x1008FF41                ), spawn "google-chrome-stable")

    -- ThinkPad mic mute button mutes mic
    , ((0, 0x1008FFB2                ), spawn myMicMuteCommand)

    -- Take a screenshot
    , ((0, xK_Print                  ), spawn ("sh $HOME/.dotfiles/screenshot.sh"))

    -- Brightness controls
    , ((0, xF86XK_MonBrightnessDown  ), spawn "xbacklight -dec 5")
    , ((0, xF86XK_MonBrightnessUp    ), spawn "xbacklight -inc 5")

    -- Lock the screen
    , ((modm .|. shiftMask, xK_z     ), spawn "xscreensaver-command --lock")
    , ((0, xF86XK_ScreenSaver        ), spawn "xscreensaver-command --lock")
    ]
    ++

    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

{-------------------------------------------------------------------------------
        VOLUME COMMANDS: COMMANDS THAT ARE ISSUED WHEN A KEY COMBINATION IS
        ACTIVATED TO ADJUST VOLUME
-------------------------------------------------------------------------------}

myAudioRaiseCommand = "amixer -M set Master 5%+"
myAudioLowerCommand = "amixer -M set Master 5%-"
myAudioMuteCommand  = "amixer set Master toggle"
myMicMuteCommand    = "amixer set Capture toggle"

{-------------------------------------------------------------------------------
        MOUSE BINDINGS: DEFAULT ACTIONS BOUND TO MOUSE EVENTS
-------------------------------------------------------------------------------}

myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2), (\w -> focus w >> windows W.swapMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3), (\w -> focus w >> F.mouseResizeWindow w))

    -- Scroll through non-empty workspaces with mod+scrollwheel
    , ((modMask, button4), (\w -> moveTo Prev NonEmptyWS))
    , ((modMask, button5), (\w -> moveTo Next NonEmptyWS))
    ]

{-------------------------------------------------------------------------------
        LAYOUTS
-------------------------------------------------------------------------------}

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-c') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.

myLayout =
    smartBorders $ avoidStruts (
        tiled ||| Mirror tiled ||| Full
    )
    ||| Full
  where
    tiled   = ResizableTall nmaster delta ratio slaves
    nmaster = 1        -- The default number of windows in the master pane
    delta   = 3/100    -- Percent of screen to increment by when resizing panes
    ratio   = 1/2      -- Default proportion of screen occupied by master pane
    slaves  = [1]

{-------------------------------------------------------------------------------
        WINDOW RULES
-------------------------------------------------------------------------------}

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.

myManageHook = composeAll
    [ title =? "Firefox Preferences" --> doFloat
    , isFullscreen --> (doF W.focusDown <+> doFullFloat)
    , manageDocks ]

{-------------------------------------------------------------------------------
        STATUS BARS AND LOGGING
-------------------------------------------------------------------------------}

myLogHook h = dynamicLogWithPP $ dzenPP
    { ppCurrent = colorize . pad
    , ppVisible = colorizeFlipped . pad
    , ppHidden  = colorizeFlipped . pad
    , ppOutput  = \s -> hPutStrLn h (s ++ " ")
    , ppLayout  = colorizeFlipped . cleanPPLayout
    , ppSep     = " "
    , ppTitle   = \s -> if all (== ' ') s then "" else colorize (pad s)
    }
  where
    pad :: String -> String
    pad str = ' ' : str ++ " "

    colorize :: String -> String
    colorize = dzenColor (myColors Foreground) (myColors Middle)

    colorizeFlipped :: String -> String
    colorizeFlipped = dzenColor (myColors Middle) (myColors Foreground)

    cleanPPLayout :: String -> String
    cleanPPLayout s = case s of
        "ResizableTall"        -> " RT "
        "Tall"                 -> " T "
        "Mirror Tall"          -> " MT "
        "Mirror ResizableTall" -> " MRT "
        "Grid"                 -> " G "
        "Full"                 -> " F "
        _                      -> " U "

{-------------------------------------------------------------------------------
        PROMPT SETTINGS
-------------------------------------------------------------------------------}

myPromptText :: String
myPromptText = ">>= "

myXPConfig :: XPConfig
myXPConfig = defaultXPConfig
    { font                = "xft:Inconsolata:size=11"
    , borderColor         = myColors Highlight
    , fgColor             = myColors Foreground
    , bgColor             = myColors Middle
    , fgHLight            = myColors Background
    , bgHLight            = myColors Foreground
    , promptBorderWidth   = 0
    , alwaysHighlight     = False
    , height              = 18
    , historySize         = 256
    , showCompletionOnTab = False
    , autoComplete        = Nothing
    , position            = Top
    }

-- The code below is a bit of a hack. It's a copy-paste from the
-- XMonad.Prompt.Shell source code whose purpose is entirely to allow me to
-- change the prompt text when running the prompt.
data MyShell = MyShell
instance XPrompt MyShell where
    showXPrompt         _ = myPromptText
    completionToCommand _ = escape

myShellPrompt partCmd = do
    cmds <- io getCommands
    mkXPrompt MyShell partCmd (getShellCompl cmds) spawn

escape :: String -> String
escape []       = ""
escape (x:xs)
    | isSpecialChar x = '\\' : x : escape xs
    | otherwise       = x : escape xs

isSpecialChar :: Char -> Bool
isSpecialChar =  flip elem " &\\@\"'#?$*()[]{};"

{-------------------------------------------------------------------------------
        STARTUP HOOK
-------------------------------------------------------------------------------}

-- Perform an arbitrary action each time xmonad starts or is restarted. Used,
-- for example, by XMonad.Layout.PerWorkspace to initialize per-workspace layout
-- choices.

-- Set the window manager name to LG3D to make Java Swing apps cooperate
myStartupHook = setWMName "LG3D"

{-------------------------------------------------------------------------------
        NOW RUN XMONAD WITH THE APPROPRIATE DEFAULTS
-------------------------------------------------------------------------------}

main = do

    -- Determine the screen width
    homeDir <- getHomeDirectory
    screenWidthString <- readFile $ homeDir ++ "/.screenwidth"
    let screenWidth = read screenWidthString

    -- Run the XMonad status bar from the left-hand edge to the exact middle of
    -- the screen
    xmonadDzenBar <- spawnPipe ("dzen2 -ta l -x 0 -y 0 -w "
        ++ show (screenWidth `div` 2) ++ " -bg '" ++ (myColors Background)
        ++ "' -fn 'Inconsolata:size=11' -e 'button3=scrollhome'")

    spawn ("sh " ++ homeDir ++ "/.xmonad/autostart")

    -- Launch Xmonad
    xmonad defaultConfig
        { terminal           = myTerminal
        , focusFollowsMouse  = myFocusFollowsMouse
        , borderWidth        = myBorderWidth
        , modMask            = myModMask
        , workspaces         = myWorkspaces
        , normalBorderColor  = myColors Background
        , focusedBorderColor = myColors Highlight
        , keys               = myKeys homeDir
        , mouseBindings      = myMouseBindings
        , layoutHook         = myLayout
        , manageHook         = myManageHook
        , logHook            = myLogHook xmonadDzenBar
        , startupHook        = myStartupHook
        }
