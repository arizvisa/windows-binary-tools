; Set the value of an INPUT TYPE=TEXT element on an invisible
; window using ControlSend()

#include <IE.au3>
#include <MsgBoxConstants.au3>

Local $oIE = _IE_Example("form")

; Hide the browser window to demonstrate sending text to invisible window
_IEAction($oIE, "invisible")

Local $oForm = _IEFormGetObjByName($oIE, "ExampleForm")
Local $oInputFile = _IEFormElementGetObjByName($oForm, "textExample")

; Assign input focus to the field and then send the text string
_IEAction($oInputFile, "focus")

; Select existing content so it will be overwritten.
_IEAction($oInputFile, "selectall")

; Get a handle to the IE window.
Local $hIE = _IEPropertyGet($oIE, "hwnd")
ControlSend($hIE, "", "[CLASS:Internet Explorer_Server; INSTANCE:1]", "This works")

_IEAction($oIE, "visible")
MsgBox($MB_SYSTEMMODAL, "Success", "Value set to 'This works'")
