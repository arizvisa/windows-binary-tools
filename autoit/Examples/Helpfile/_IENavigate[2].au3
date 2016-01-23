; Create a browser window and navigate to a website,
; do not wait for page load to complete before moving to next line

#include <IE.au3>
#include <MsgBoxConstants.au3>

Local $oIE = _IECreate("www.autoitscript.com", 0)
MsgBox($MB_SYSTEMMODAL, "_IENavigate()", "This code executes immediately")
