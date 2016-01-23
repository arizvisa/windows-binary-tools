#include <MsgBoxConstants.au3>

AutoItSetOption("WinTitleMatchMode", 2)

Local $sText = StatusbarGetText("Internet Explorer")
MsgBox($MB_SYSTEMMODAL, "", "Internet Explorer's status bar says: " & $sText)
