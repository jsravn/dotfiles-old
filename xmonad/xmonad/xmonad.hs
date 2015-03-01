--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--

-- Normally, you'd only override those defaults you care about.
--

import XMonad

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- Various
import XMonad.Config.Xfce
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageHelpers

-- Layouts
import XMonad.Layout.SimpleFloat
import XMonad.Layout.NoBorders
import Data.List
import XMonad.Hooks.EwmhDesktops

-- Config
myTerminal      = "urxvt -name zenburn"
myModMask       = mod4Mask
myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#dcdccc"

myLayout = smartBorders . avoidStruts $
           (Full ||| tiled ||| simpleFloat)
  where
     tiled   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100

q ~=? x = fmap (isPrefixOf x) q

myManageHook =
  composeOne [
    isFullscreen                     -?> doFullFloat
    , className =? "Gimp"            -?> doFloat
    , resource  =? "Calendar"        -?> doFloat
    , className =? "Nautilus"        -?> doFloat
    , className =? "Xfrun4"          -?> doFloat
    , className =? "Xfce4-appfinder" -?> doFloat
    , title     =? "Whisker Menu"    -?> doFloat
    , (className ~=? "jetbrains-") <&&> (title ~=? "win") -?> doIgnore
    ] <+> manageHook xfceConfig

myLogHook = do
  logHook xfceConfig

myStartupHook = do
  startupHook xfceConfig
  setWMName "LG3D"

myUrgencyHook = NoUrgencyHook

myPP :: PP
myPP = defaultPP { ppOrder = \(_:l:_) -> [l] }

main = xmonad $ withUrgencyHook myUrgencyHook $ defaults

defaults = xfceConfig {
        terminal           = myTerminal,
        modMask            = myModMask,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }
    `additionalKeys`
           [ ((mod4Mask, xK_p), spawn "xfce4-popup-whiskermenu"),
             ((mod4Mask, xK_space ), sendMessage NextLayout
                                     >> notifyLayout) ]
  where
    notifyLayout = dynamicLogString myPP >>= notifySend
    notifySend d = spawn $ "/usr/bin/notify-send \"" ++ d ++ " \""
