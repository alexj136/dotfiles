-- Alex's Xmonad Configuration File

------------------------------------------------------------------------
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
import XMonad.Layout.Spacing

import Graphics.X11.ExtraTypes.XF86

import System.Exit

import System.IO (stderr)

import Network.BSD (HostName, getHostName)

import qualified XMonad.StackSet               as W
import qualified XMonad.Actions.FlexibleResize as F
import qualified Data.Map                      as M
 
------------------------------------------------------------------------
-- Simple settings

myTerminal           = "uxterm"
myBorderWidth        = 2         -- Blue/White Scheme
myNormalBorderColor  = "#002b36" -- "#111111"
myFocusedBorderColor = "#268bd2" -- "#3333aa"
myLogFG1Color        = "#eee8d5" -- "#3333aa"
myLogFG2Color        = "#586e75" -- "#eeeeee"
myLogBGColor         = "#002b36" -- "#111111"
myModMask            = mod4Mask
myWorkspaces         = map show [1..9]
myFocusFollowsMouse  = True
 
------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
 
    -- launch a terminal
    [ ((modm              , xK_Return), spawn $ XMonad.terminal conf)
    , ((modm              , xK_t     ), spawn $ XMonad.terminal conf)
 
    -- launch firefox
    , ((modm,               xK_y     ), spawn "firefox" )

    -- launch zathura
    , ((modm,               xK_u     ), spawn "zathura" )
 
    -- launch dmenu
    , ((modm,               xK_d     ), spawn "exe=`dmenu_run -b` && eval \"exec $exe\"")
 
    -- close focused window 
    , ((modm .|. shiftMask, xK_q     ), kill)
 
     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)
 
    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
 
    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)
 
    -- Cycle non-empty workspaces with mod+tab or mod+shift+tab
    , ((modm,               xK_Tab   ), moveTo Next NonEmptyWS)
    , ((modm .|. shiftMask, xK_Tab   ), moveTo Prev NonEmptyWS)
 
    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)
 
    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp)
 
    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster)
 
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

    -- Volume keys
    , ((0, xF86XK_AudioLowerVolume   ), spawn "amixer -M set Master 5%-")
    , ((0, xF86XK_AudioRaiseVolume   ), spawn "amixer -M set Master 5%+")
    , ((0, xF86XK_AudioMute          ), spawn "amixer set Master toggle")

    -- Lock the screen
    , ((modm .|. shiftMask, xK_z     ), spawn "xscreensaver-command --lock")
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
 
 
------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events

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
 
------------------------------------------------------------------------
-- Layouts
 
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-c') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.

myLayout =
    smartSpacing 4 $ smartBorders $ avoidStruts (
        tiled1 ||| Mirror tiled1 ||| tiled2 ||| Mirror tiled2 ||| Full
    )
    ||| Full
  where
    tiled1   = ResizableTall nmaster1 delta ratio slaves
    tiled2   = ResizableTall nmaster2 delta ratio slaves
    nmaster1 = 1        -- The default number of windows in the master pane
    nmaster2 = 2
    delta    = 3/100    -- Percent of screen to increment by when resizing panes
    ratio    = 1/2      -- Default proportion of screen occupied by master pane
    slaves   = [1]
 
------------------------------------------------------------------------
-- Window rules
 
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
 
------------------------------------------------------------------------
-- Status bars and logging

myLogHook h = dynamicLogWithPP $ dzenPP
    { ppCurrent = colorize . pad
    , ppVisible = colorizeFlipped . pad
    , ppHidden  = colorizeFlipped . pad
    , ppOutput  = \s -> hPutStrLn h (s ++ " ")
    , ppLayout  = colorizeFlipped . cleanLayout
    , ppSep     = " "
    , ppTitle   = \s -> if all (== ' ') s
                            then ""
                            else colorize $ pad s
    }
  where
    pad :: String -> String
    pad str = ' ' : str ++ " "

    colorize :: String -> String
    colorize = dzenColor myLogFG1Color myLogFG2Color 

    colorizeFlipped :: String -> String
    colorizeFlipped = dzenColor myLogFG2Color myLogFG1Color 

    cleanLayout :: String -> String
    cleanLayout s = case s of
        "SmartSpacing 4 ResizableTall"        -> " RT "
        "SmartSpacing 4 Tall"                 -> " T "
        "SmartSpacing 4 Mirror Tall"          -> " MT "
        "SmartSpacing 4 Mirror ResizableTall" -> " MRT "
        "SmartSpacing 4 Grid"                 -> " G "
        "SmartSpacing 4 Full"                 -> " F "
        _                                     -> " U "

------------------------------------------------------------------------
-- Startup hook
 
-- Perform an arbitrary action each time xmonad starts or is restarted. Used,
-- for example, by XMonad.Layout.PerWorkspace to initialize per-workspace layout
-- choices.

-- Set the window manager name to LG3D to make Java Swing apps cooperate
myStartupHook = setWMName "LG3D"
 
------------------------------------------------------------------------
-- Now run xmonad with the appropriate defaults

main = do

    host <- getHostName

    -- Xmonad status bar
    xmonadDzenBar <- spawnPipe $
        case host of
            "Alex-ThinkPad" ->
                "dzen2 -ta l -x 0 -y 0 -w 800 -bg '" ++ myLogBGColor
                ++ "' -fn \'Inconsolata:size=11'"
            "Alex-Desktop"  ->
                "dzen2 -ta l -x 0 -y 0 -w 960 -bg '" ++ myLogBGColor
                ++ "' -fn \'Inconsolata:size=11'"
            other           ->
                "echo \'Hostname: " ++ other ++ " not recognised\' > ~/xmoErr"

    -- Launch Xmonad
    xmonad defaultConfig
        { terminal           = myTerminal
        , focusFollowsMouse  = myFocusFollowsMouse
        , borderWidth        = myBorderWidth
        , modMask            = myModMask
        , workspaces         = myWorkspaces
        , normalBorderColor  = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor
        , keys               = myKeys
        , mouseBindings      = myMouseBindings
        , layoutHook         = myLayout
        , manageHook         = myManageHook
        , logHook            = myLogHook xmonadDzenBar
        , startupHook        = myStartupHook
        }
