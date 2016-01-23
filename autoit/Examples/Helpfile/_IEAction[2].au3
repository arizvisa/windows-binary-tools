; Same as Example 1, except instead of using click, give the element focus
; and then use ControlSend to send Enter.  Use this technique when the
; browser-side scripting associated with a click action prevents control
; from being automatically returned to your code.

#include <IE.au3>

Local $oIE = _IE_Example("form")
Local $oSubmit = _IEGetObjByName($oIE, "submitExample")
Local $hWnd = _IEPropertyGet($oIE, "hwnd")
_IEAction($oSubmit, "focus")
ControlSend($hWnd, "", "[CLASS:Internet Explorer_Server; INSTANCE:1]", "{Enter}")

; Wait for Alert window, then click on OK
WinWait("", "ExampleFormSubmitted")
Sleep(2000)

ControlClick("", "ExampleFormSubmitted", "[CLASS:Button; TEXT:OK; Instance:1;]")
Sleep(2000)

_IEQuit($oIE)
