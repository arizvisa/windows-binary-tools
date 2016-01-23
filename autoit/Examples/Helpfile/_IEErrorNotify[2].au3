#include <IE.au3>
#include <MsgBoxConstants.au3>

MsgBox($MB_SYSTEMMODAL, "_IEErrorNotify Status", "Notification now is " & _IEErrorNotify())

ConsoleWrite(@CRLF)
ConsoleWrite('! Look what happens when _IEErrorNotify is ON' & @CRLF)
Local $oIE = _IECreate('www.google') ; URL is broken
Local $oForm = _IEFormGetObjByName($oIE, "gbqf")
Local $oQuery = _IEFormElementGetObjByName($oForm, "q")
_IEFormElementSetValue($oQuery, "AutoIt IE.au3")
_IEFormSubmit($oForm)
_IEQuit($oIE)
ConsoleWrite('! This is what you can see in console when _IEErrorNotify is Turned ON' & @CRLF)

ConsoleWrite(@CRLF)
_IEErrorNotify_ON_OFF()
MsgBox($MB_SYSTEMMODAL, "_IEErrorNotify Status", "Notification now is " & _IEErrorNotify())

ConsoleWrite(@CRLF)
ConsoleWrite('! Now look what happens when _IEErrorNotify is OFF' & @CRLF)
$oIE = _IECreate('www.google') ; URL is broken
$oForm = _IEFormGetObjByName($oIE, "gbqf")
; $oForm = _IEFormGetObjByName($oIE, "gbqf")
$oQuery = _IEFormElementGetObjByName($oForm, "q")
_IEFormElementSetValue($oQuery, "AutoIt IE.au3")
_IEFormSubmit($oForm)
_IEQuit($oIE)
ConsoleWrite('! This is what you can see in console when _IEErrorNotify is Turned OFF' & @CRLF)
ConsoleWrite(@CRLF)

_IEErrorNotify_ON_OFF()
MsgBox($MB_SYSTEMMODAL, "_IEErrorNotify Status", "Notification now is " & _IEErrorNotify())
ConsoleWrite(@CRLF)

ConsoleWrite(@CRLF)
ConsoleWrite('! Look what happens when _IEErrorNotify is ON with some ERRORs' & @CRLF)
$oIE = _IECreate('www.google.com') ; URL is OK
$oForm = _IEFormGetObjByName($oIE, "gbqf", 1) ; try to retrieve the index = 1 -> ERROR
$oQuery = _IEFormElementGetObjByName($oForm, "q", 1) ; try to retrieve the index = 1 -> ERROR
_IEFormElementSetValue($oQuery, "AutoIt IE.au3")
_IEFormSubmit($oForm)
_IEQuit($oIE)
ConsoleWrite('! This is what you can see in console when _IEErrorNotify is Turned ON' & @CRLF)

Func _IEErrorNotify_ON_OFF()
	If _IEErrorNotify() Then
		MsgBox($MB_SYSTEMMODAL, "_IEErrorNotify Status", "Notification is ON, turning it OFF")
		ConsoleWrite('> Turning _IEErrorNotify OFF' & @CRLF)
		_IEErrorNotify(False)
	Else
		MsgBox($MB_SYSTEMMODAL, "_IEErrorNotify Status", "Notification is OFF, turning it ON")
		ConsoleWrite('> Turning _IEErrorNotify ON' & @CRLF)
		_IEErrorNotify(True)
	EndIf
EndFunc   ;==>_IEErrorNotify_ON_OFF
