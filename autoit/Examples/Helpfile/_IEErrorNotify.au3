; Check the current status of _IEErrorNotify, turn it off if on, on if off

#include <IE.au3>
#include <MsgBoxConstants.au3>

If _IEErrorNotify() Then
	MsgBox($MB_SYSTEMMODAL, "_IEErrorNotify Status", "Notification is ON, turning it OFF")
	_IEErrorNotify(False)
Else
	MsgBox($MB_SYSTEMMODAL, "_IEErrorNotify Status", "Notification is OFF, turning it ON")
	_IEErrorNotify(True)
EndIf
