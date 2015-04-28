--
-- xmonad inside of xfce
-- author: James Ravn <james@r-vn.org>
--
-- disable xfwm4 and xfdesktoo
--

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import XMonad
import XMonad.Config.Xfce
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.SimpleFloat
import XMonad.Layout.NoBorders
import Data.List
import XMonad.Util.EZConfig(additionalKeys)

conf = ewmh xfceConfig {
        terminal           = "urxvt -name zenburn",
        modMask            = mod4Mask,
        normalBorderColor  = "#000000",
        focusedBorderColor = "#dcdccc",
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        logHook            = ewmhDesktopsLogHook,
        startupHook        = myStartupHook
    }
    `additionalKeys` myKeyBindings

-- Layout

myLayout = smartBorders . avoidStruts $
           (Full ||| tiled ||| simpleFloat)
  where
     tiled   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100

q ~=? x = fmap (isPrefixOf x) q

-- Window management

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

myPP :: PP
myPP = defaultPP { ppOrder = \(_:l:_) -> [l] }

myKeyBindings = [
  ((mod4Mask, xK_p), spawn "xfce4-popup-whiskermenu"),
  ((mod4Mask, xK_space ), sendMessage NextLayout >> notifyLayout)
  ]
  where
    notifyLayout = dynamicLogString myPP >>= notifySend
    notifySend d = spawn $ "/usr/bin/notify-send \"" ++ d ++ " \""

-- Main
main = xmonad $ conf
