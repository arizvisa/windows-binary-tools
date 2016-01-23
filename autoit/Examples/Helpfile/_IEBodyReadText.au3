; Open a browser with the basic example, read the body Text
; (the content with all HTML tags removed) and display it in a MsgBox

#include <IE.au3>
#include <MsgBoxConstants.au3>

Local $oIE = _IE_Example("basic")
Local $sText = _IEBodyReadText($oIE)
MsgBox($MB_SYSTEMMODAL, "Body Text", $sText)

_IEQuit($oIE)
