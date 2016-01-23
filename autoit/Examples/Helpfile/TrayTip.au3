#include <MsgBoxConstants.au3>
#include <TrayConstants.au3>

TrayTip("I'm a title", "I'm the message", 0, $TIP_ICONASTERISK)
MsgBox($MB_SYSTEMMODAL, "", "Press OK to reset the tip.")
TrayTip("clears any tray tip", "", 0)
MsgBox($MB_SYSTEMMODAL, "", "Press OK to see another tip.")
TrayTip("", "A different tray tip.", 5)
Sleep(5000)
